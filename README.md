# ActiveAdmin CEP Auto Complete (brazilian postal code)
Auto complete your addresses fields with Brazilian CEP (zip code).

## Installation
Include to your Gemfile
```ruby
gem 'active_admin-cep_auto_complete'
```

## Usage
**1. Create a custom page in `app/admin/cep.rb`**
```ruby
ActiveAdmin.register_page 'CEP' do
  include ActiveAdmin::CepAutoComplete::Page
end
```

**2. Add a CEP Input**
```ruby
f.input :cep, as: :cep
f.input :street
f.input :state
f.input :city
f.input :neighborhood
```

*p.s. if you have a different input name, you'll have to change your [URL option](https://github.com/dhyegofernando/active_admin-cep_auto_complete#options).*

**3. It works!!**

## Options

**Input options**

Option        | Type         | Default                                            | Description
---           | ---          | ---                                                | ---
`url`         | *string*     | Singular name of the input. e.g. `/cep`            | The route URL that CEP will be fetched from.
`fields`      | *array*      | `[:street, :state, :city, :neighborhood]`          | The inputs names which will be auto completed.

## Custom fields

If you want to add any custom field to be autocompleted, just do the follow:

**1. Add to the CEP input options**
```ruby
f.input :cep, as: :cep, fields: [:state_id]
f.input :state_id
```

**2. Add the render method to the controller**
```ruby
ActiveAdmin.register_page 'CEP' do
  setup_cep_auto_complete do
    # New field
    field :state_id do |cep|
      state = State.where("title LIKE '%?%'", cep.state).take
      
      if state.any?
        state.id
      end
    end
    
    # Another new field that uses a result from other one
    field :some_other_field do |cep|
      "State number #{cep.state_id}"
    end
    
    # Override an original field
    field :street do |cep|
      "Street #{cep.street}"
    end
  end
end
```

**3. Now, the javascript will auto trigger the field with something like this:**
```javascript
$('#address_state_id').val(cep.state_id);
```

*p.s. it just a pseudo-code*

**If you want support a different plugin (like [select2](https://github.com/select2/select2)) or any other javascript render method, you can do:**

```javascript
$('#address_state_id').on('active_admin:cep_auto_complete', function(e, value, cep, input) {
  $(this).val(cep.state_id);
  $(this).trigger('change');
});
```

## Maintainer
[Dhyego Fernando](https://github.com/dhyegofernando)
