module NagiraActiveResource 

  ##
  # Rails-like methods for Nagira host class
  #
  class Host  < ActiveResource::Base

    ##
    # Return all hosts as Hash
    #
    def self.to_h
      self.all.map &:attributes
    end
    
    ##
    # Find host by attribute and its value
    #
    # @param [String] attribute
    # @param [String] value
    #
    def self.find_by attribute, value
      raise "No such attribute '#{attribute}'" unless first.attributes.has_key? attribute
      to_h.find { |x| x[attribute.to_s] == value.to_s  }
    end
    
    
    ##
    # Find hosts by attribute and its value
    #
    # @param [String] attribute
    # @param [String] value
    #
    def self.find_all_by attribute, value
      raise "No such attribute '#{attribute}'" unless first.attributes.has_key? attribute
      to_h.reject { |x| x[attribute.to_s] != value.to_s  }
    end

    ##
    # Dynamic methods for search
    #
    def self.method_missing sym, *args, &block
      if sym.to_s =~ /^(find(_all)?)_by_(.*)$/
        # message - either 'find' of 'find_all'
        # resource - type of objects to search: host, hostgroup etc.
        # attribute - name of the attribute to do search by: :host_name, :check_command
        # @param *args String or Regexp to search objects
        message,attribute  = $1, $3
        all = $2
        p all

        case all
        when '_all'
          find_all_by attribute, args[0]
        when nil
          find_by attribute, args[0]
        end

      else
        super  sym, *args, &block
      end
      # raise(NoMethodError, "No such method #{sym.to_s} for #{self}") unless 
      
    end

  end
end

