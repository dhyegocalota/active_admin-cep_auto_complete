module Formtastic
  module Inputs
    class CepInput < StringInput
      def input_html_options
        opts = super
        data = (opts[:data] || {}).merge(fields: load_fields(input_options[:fields]),
                                         url: load_url(input_options[:url]),
                                         scope: load_scope(opts[:id]),
                                         cep_regex: cep_regex)
        opts.merge(class: load_class(opts[:class]), data: data)
      end

      protected

      def load_class(classes)
        @classes ||= (classes || '').to_s.split(' ').tap { |classes| classes << 'cep-auto-complete' }.join(' ')
      end

      def load_fields(fields)
        @fields ||= begin
          raise "Expected Array got #{fields.class}" if !fields.blank? && !fields.is_a?(Array)
          (fields || ActiveAdmin::CepAutoComplete::DEFAULT_FIELDS).to_json
        end
      end

      def load_url(url)
        @url ||= begin
          if url.nil?
            url = ['/']

            if ActiveAdmin.application.default_namespace.present?
              url << "#{ActiveAdmin.application.default_namespace}/"
            end

            url << urlize_method
            url.join('')
          else
            url
          end
        end
      end

      def load_scope(id)
        id.chomp('_' + method.to_s)
      end

      def cep_regex
        "^#{ActiveAdmin::CepAutoComplete::CEP_REGEX_BODY}$"
      end

      def association_name
        method.to_s.singularize.chomp('_id')
      end

      def urlize_method
        association_name.underscore
      end
    end
  end
end
