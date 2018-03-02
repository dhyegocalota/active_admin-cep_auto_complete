module ActiveAdmin
  module CepAutoComplete
    class Query
      def self.search(cep)
        address = PostmonRuby::Client.search(:cep, cep)
        return if address.not_found
        {
          cep: cep,
          state: address.estado,
          city: address.cidade,
          neighborhood: address.bairro,
          street: address.logradouro
        }
      end
    end
  end
end
