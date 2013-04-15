module NagiraActiveResource 

  ##
  # Rails-like methods for Nagira host class
  #
  class Base  < ActiveResource::Base

    ##
    # Return all objects as Hash
    #
    # @param [Hash] args Extra arguents like :host_name for nested
    #     objects (services) :params => !{'host_name' => 'viy'}
    def self.to_h args={ }
      self.all(args).map &:attributes
    end
    
    ##
    # Find host by attribute and its value
    #
    # @param [String] attribute
    #
    # @param [String] value
    #
    # @param [Hash] args Extra arguents like :host_name for nested
    #     objects (services) :params => !{'host_name' => 'viy'}
    #
    def self.find_by attribute, value, args={ }
      # TODO: .first does not work for services, since 1st is 'Check time'
      raise "No such attribute '#{attribute}'" unless last(args).attributes.has_key? attribute
      self.to_h(args).find { |x| x[attribute.to_s] == value.to_s  }
    end
    
    
    ##
    # Find hosts by attribute and its value
    #
    # @param [String] attribute
    #
    # @param [String] value
    #
    # @param [Hash] args Extra arguents like :host_name for nested
    #     objects (services) :params => !{'host_name' => 'viy'}
    #
    def self.find_all_by attribute, value, args={ }
      raise "No such attribute '#{attribute}'" unless last(args).attributes.has_key? attribute
      to_h(args).reject { |x| x[attribute.to_s] != value.to_s  }
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
        message,all,attribute  = $1, $2, $3
        
        value = args.shift
        
        case all
        when '_all'
          find_all_by attribute, value, *args
        when nil
          find_by attribute, value, *args
        end
        
      else
        super  sym, *args, &block
      end
    end
    
  end
end

