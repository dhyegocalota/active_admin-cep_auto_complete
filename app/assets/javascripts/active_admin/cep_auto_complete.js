//= require active_admin/utils

(function(scope, $) {
  'use strict';

  function CepInput(input) {
    this.input = input;
    this.form = input.closest('form');
    this.scope = this.input.data('scope');
    this.url = this.input.data('url');
    this.fields = this.input.data('fields').reduce(function(fields, field) {
      fields[field] = this.findField(field);
      return fields;
    }.bind(this), {});
    this.cepRegex = new RegExp(this.input.data('cepRegex'));
    this.onChange = scope.Utils.debounce(this.onChange.bind(this), 300);
    this.lastQuery = null;
    this.attachEvents();
  }

  CepInput.attach = function(selector) {
    $(selector).each(function() {
      var self = $(this);
      self.data('cepInput', new CepInput(self));
    });
  };

  CepInput.prototype = {
    attachEvents: function() {
      this.input.on('keypress', this.onChange);
    },

    findField: function(field) {
      return $('#' + this.scope + '_' + field);
    },

    onChange: function(e) {
      if (this.isValid(e.delegateTarget.value)) {
        this.query(e.delegateTarget.value);
      }
    },

    isValid: function(value) {
      return !!value.match(this.cepRegex);
    },

    query: function(value) {
      if (this.lastQuery !== null) {
        this.lastQuery.abort();
      }

      this.lockFields();
      this.lastQuery = $.get(this.url, { cep: value })
        .then(function(data) {
          this.render(data);
          this.lastQuery = null;
          this.unlockFields();
        }.bind(this))
        .fail(function() {
          this.lastQuery = null;
          this.unlockFields();
        }.bind(this));
    },

    render: function(data) {
      $.each(this.fields, function(field, element) {
        var value = data[field];
        element.val(value);
        element.trigger('change');
        element.trigger('active_admin:cep_auto_complete', [value, data, this]);
      }.bind(this));
    },

    lockFields: function() {
      this.toggleFields(true);
    },

    unlockFields: function() {
      this.toggleFields(false);
    },

    toggleFields: function(disabled) {
      $.each(this.fields, function(field, element) {
        element.prop('disabled', disabled);
      });
    }
  };

  $(document).ready(function() {
    CepInput.attach('.cep-auto-complete');
  });

  scope.CepInput = CepInput;
}(window.ActiveAdmin, jQuery));
