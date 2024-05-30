class UserLifeplanAssetDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  class << self
    def form_objects(user, f)
      if user.is_a?(AdminUser)
        admin_form_objects(user, f)
      else
        member_form_objects(user, f)
      end
    end

    def member_form_objects(member, f)
      common_form_object(f)
    end

    def admin_form_objects(admin, f)
      common_form_object(f)
    end

    def form_columns
      %i[ user_lifeplan_asset_kind cache_deposit_kind other_assets_kind amount_of_money financial_institution_name
          store_name account_number reference_on rate content company_name asset_appraisal_value equity_appraisal_value
          scheduled_for_sale sundry_expenses profit description
      ]
    end

    private

    def common_form_object(f)
      [
        [ init_form( f, {
          code: :user_lifeplan_asset_kind,
          input: f.select(:user_lifeplan_asset_kind,
                          UserLifeplanAsset.user_lifeplan_asset_kind.values.map { |v| [v.text, v.value] }, {},
                          class: f.object.decorate.input_class(:user_lifeplan_asset_kind, :admin),
                          disabled: true),
          col: 6, no_required: false, help: '', alert: ''
        }) ],
        # [ init_form( f, {
        #     code: :name,
        #     input: f.text_field(:name, class: f.object.decorate.input_class(:name, :admin)),
        #     col: 6, no_required: false, help: '', alert: ''
        # }) ],
        [ init_form( f, {
          code: :cache_deposit_kind,
          input: f.select(:cache_deposit_kind,
                          UserLifeplanAsset.cache_deposit_kind.values.map { |v| [v.text, v.value] }, {},
                          class: f.object.decorate.input_class(:cache_deposit_kind, :admin),
                          disabled: f.object.other_assets?),
          col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
          code: :other_assets_kind,
          input: f.select(:other_assets_kind,
                          UserLifeplanAsset.other_assets_kind.values.map { |v| [v.text, v.value] }, {},
                          class: f.object.decorate.input_class(:other_assets_kind, :admin),
                          disabled: f.object.cash_deposits?),
          col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
          code: :amount_of_money,
          input: f.number_field(:amount_of_money, class: f.object.decorate.input_class(:amount_of_money, :admin)),
          col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
          code: :financial_institution_name,
          input: f.text_field(:financial_institution_name,
                              class: f.object.decorate.input_class(:financial_institution_name, :admin),
                              disabled: f.object.other_assets?),
          col: 6, no_required: false, help: '', alert: ''
        }) ],
        [
          init_form( f, {
            code: :store_name,
            input: f.text_field(:store_name, class: f.object.decorate.input_class(:store_name, :admin),
                          disabled: f.object.other_assets?),
            col: 6, no_required: false, help: '', alert: ''
          })
        ],
        [ init_form( f, {
          code: :account_number,
          input: f.text_field(:account_number, class: f.object.decorate.input_class(:account_number, :admin),
                          disabled: f.object.other_assets?),
          col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
          code: :reference_on,
          input: f.text_field(:reference_on, class: f.object.decorate.input_class(:reference_on, :admin), type: 'date',
                          disabled: f.object.other_assets?),
          col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
          code: :rate,
          input: f.number_field(:rate, class: f.object.decorate.input_class(:rate, :admin),
                          disabled: f.object.cash_deposits?),
          col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
          code: :content,
          input: f.text_field(:content, class: f.object.decorate.input_class(:content, :admin),
                          disabled: f.object.cash_deposits?),
          col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
          code: :company_name,
          input: f.text_field(:company_name, class: f.object.decorate.input_class(:company_name, :admin),
                          disabled: f.object.cash_deposits?),
          col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
          code: :asset_appraisal_value,
          input: f.number_field(:asset_appraisal_value,
                                class: f.object.decorate.input_class(:asset_appraisal_value, :admin),
                          disabled: f.object.cash_deposits?),
          col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
          code: :equity_appraisal_value,
          input: f.number_field(:equity_appraisal_value,
                                class: f.object.decorate.input_class(:equity_appraisal_value, :admin),
                          disabled: f.object.cash_deposits?),
          col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
          code: :scheduled_for_sale,
          input: f.number_field(:scheduled_for_sale, class: f.object.decorate.input_class(:scheduled_for_sale, :admin),
                          disabled: f.object.cash_deposits?),
          col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
          code: :sundry_expenses,
          input: f.number_field(:sundry_expenses, class: f.object.decorate.input_class(:sundry_expenses, :admin),
                          disabled: f.object.cash_deposits?),
          col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
          code: :profit,
          input: f.number_field(:profit, class: f.object.decorate.input_class(:profit, :admin),
                          disabled: f.object.cash_deposits?),
          col: 6, no_required: false, help: '', alert: ''
        }) ],
        [ init_form( f, {
          code: :description,
          input: f.text_area(:description, class: f.object.decorate.input_class(:description, :admin)),
          col: 12, no_required: false, help: '', alert: ''
        }) ]
      ]
    end
  end
end
