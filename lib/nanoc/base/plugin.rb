module Nanoc

  # Nanoc::Plugin is the superclass for all plugins, such as filters,
  # layout processors and data sources.
  class Plugin

    MAP = {}

    class << self

      # Sets or returns the identifiers for this plugin.
      #
      # When given a list of identifier symbols, sets the identifiers for
      # this plugin. When given nothing, returns an array of identifier
      # symbols for this plugin.
      def identifiers(*identifiers)
        # Initialize
        @identifiers = [] unless instance_variables.include?('@identifiers')

        if identifiers.empty?
          @identifiers
        else
          @identifiers = identifiers
          @identifiers.each { |i| register(i, self) }
        end
      end

      # Sets or returns the identifier for this plugin.
      #
      # When given an identifier symbols, sets the identifier for this plugin.
      # When given nothing, returns the identifier for this plugin.
      def identifier(identifier=nil)
        # Initialize
        @identifiers = [] unless instance_variables.include?('@identifiers')

        if identifier.nil?
          @identifiers.first
        else
          @identifiers = [ identifier ]
          register(identifier, self)
        end
      end

      # Registers the given class +klass+ with the given name. This will allow
      # the named method to find the class.
      def register(name, klass)
        MAP[klass.superclass] ||= {}
        MAP[klass.superclass][name.to_sym] = klass
      end

      # Returns the the plugin with the given name. Only subclasses of this
      # class will be searched. For example, calling this method on
      # Nanoc::Filter will cause only Nanoc::Filter subclasses to be searched.
      def named(name)
        MAP[self] ||= {}
        MAP[self][name.to_sym]
      end

    end

  end

end
