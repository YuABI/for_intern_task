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
    def form_objects(f)
      common_form_object(f)
    end

    def member_form_objects(member, f)
      common_form_object(f)
    end

    private

    def common_form_object(f)
      [
        [
          init_form( f, {
              code: :name,
              input: f.text_field(:name, class: f.object.decorate.input_class(:name, :admin)),
              col: 6, no_required: false, help: '', alert: ''
          })
        ],
        [
          init_form( f, {
            code: :rate,
            input: f.number_field(:rate, class: f.object.decorate.input_class(:rate, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          })
        ],
        [
          init_form(
            f,
            {
              code: :asset_kind,
              input: f.number_field(:asset_kind, class: f.object.decorate.input_class(:asset_kind, :admin)),
              col: 6, no_required: false, help: '', alert: ''
            }
          )
        ],
        [
          init_form( f, {
            code: :other_assets_kind,
            input: f.text_field(:other_assets_kind, class: f.object.decorate.input_class(:other_assets_kind, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          })
        ],
        [
          init_form( f, {
            code: :financial_institution_name,
            input: f.text_field(:financial_institution_name, class: f.object.decorate.input_class(:financial_institution_name, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          })
        ],
        [
          init_form(
            f,
            {
              code: :store_name,
              input: f.text_field(:store_name, class: f.object.decorate.input_class(:store_name, :admin)),
              col: 6, no_required: false, help: '', alert: ''
            }
          )
        ],
        [
          init_form(
            f,
            {
              code: :deposit_kind,
              input: f.number_field(:deposit_kind, class: f.object.decorate.input_class(:deposit_kind, :admin)),
              col: 6, no_required: false, help: '', alert: ''
            }
          )
        ],
        [
          init_form(
            f,
            {
              code: :account_number,
              input: f.text_field(:account_number, class: f.object.decorate.input_class(:account_number, :admin)),
              col: 6, no_required: false, help: '', alert: ''
            }
          )
        ],
        [
          init_form(
            f,
            {
              code: :reference_at,
              input: f.datetime_select(:reference_at, class: f.object.decorate.input_class(:reference_at, :admin)),
              col: 6, no_required: false, help: '', alert: ''
            }
          )
        ],
        [
          init_form(
            f,
            {
              code: :amount_of_money,
              input: f.number_field(:amount_of_money, class: f.object.decorate.input_class(:amount_of_money, :admin)),
              col: 6, no_required: false, help: '', alert: ''
            }
          )
        ],
        [
          init_form(
            f,
            {
              code: :content,
              input: f.text_field(:content, class: f.object.decorate.input_class(:content, :admin)),
              col: 6, no_required: false, help: '', alert: ''
            }
          )
        ],
        [
          init_form(
            f,
            {
              code: :company_name,
              input: f.text_field(:company_name, class: f.object.decorate.input_class(:company_name, :admin)),
              col: 6, no_required: false, help: '', alert: ''
            }
          )
        ],
        [
          init_form(
            f,
            {
              code: :asset_number,
              input: f.number_field(:asset_number, class: f.object.decorate.input_class(:asset_number, :admin)),
              col: 6, no_required: false, help: '', alert: ''
            }
          )
        ],
        [
          init_form(
            f,
            {
              code: :asset_appraisal_value,
              input: f.number_field(:asset_appraisal_value, class: f.object.decorate.input_class(:asset_appraisal_value, :admin)),
              col: 6, no_required: false, help: '', alert: ''
            }
          )
        ],
        [
          init_form( f, {
            code: :cache_deposit_kind,
            input: f.number_field(:cache_deposit_kind, class: f.object.decorate.input_class(:cache_deposit_kind, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          })
        ],
        [
          init_form( f, {
            code: :equity_appraisal_value,
            input: f.number_field(:equity_appraisal_value, class: f.object.decorate.input_class(:equity_appraisal_value, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          })
        ],
        [
          init_form(
            f,
            {
              code: :scheduled_for_sale,
              input: f.number_field(:scheduled_for_sale, class: f.object.decorate.input_class(:scheduled_for_sale, :admin)),
              col: 6, no_required: false, help: '', alert: ''
            }
          )
        ],
        [
          init_form( f, {
            code: :user_lifeplan_asset_kind,
            input: f.number_field(:user_lifeplan_asset_kind, class: f.object.decorate.input_class(:user_lifeplan_asset_kind, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          })
        ],
        [
          init_form( f, {
            code: :sundry_expenses,
            input: f.number_field(:sundry_expenses, class: f.object.decorate.input_class(:sundry_expenses, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          })
        ],
        [
          init_form( f, {
            code: :profit,
            input: f.number_field(:profit, class: f.object.decorate.input_class(:profit, :admin)),
            col: 6, no_required: false, help: '', alert: ''
          })
        ],
        [
          init_form(
            f,
            {
              code: :description,
              input: f.text_field(:description, class: f.object.decorate.input_class(:description, :admin)),
              col: 12, no_required: false, help: '', alert: ''
            }
          )
        ]
      ]
    end
  end
end
