# frozen_string_literal: true

class Members::UserLifeplans::BlanceGraphComponent < Members::BaseComponent
  attr_reader :user_lifeplan_decorator, :user_lifeplan_yearly_blance

  def initialize(**args)
    super(**args)

    @user_lifeplan_decorator = args[:user_lifeplan_decorator]
    @user_lifeplan_yearly_blance = args[:user_lifeplan_yearly_blance]
  end

  def each_year_balances
    user_lifeplan_yearly_blance.each_year_balances.values
  end

  def chart_data
    {
      labels: each_year_balances.map { |balance| "#{balance.age}歳" },
      datasets: [
        {
          label: '収入合計',
          type: "line",
          fill: false,
          data: each_year_balances.map(&:incomes_amount_total),
          borderColor: "rgba(255,255,84,1)",
          backgroundColor: "rgba(255,255,84,1)",
          yAxisID: "incomeAndExpense",
        },
        {
          label: '現金預金',
          type: "line",
          fill: false,
          data: each_year_balances.map(&:cash_deposits_amount),
          borderColor: "rgba(66,115,177,1)",
          backgroundColor: "rgba(66,115,177,1)",
          yAxisID: "assets",
        },
        {
          label: 'その他資産',
          type: "line",
          fill: false,
          data: each_year_balances.map(&:other_assets_amount),
          borderColor: "rgba(105, 66, 177,1)",
          backgroundColor: "rgba(105, 66, 177,1)",
          yAxisID: "assets",
        },
        {
          label: '終活',
          data: each_year_balances.map(&:end_of_life_amount),
          borderColor: "rgba(208,206,206, 1)",
          backgroundColor: "rgba(208,206,206, 1)",
          yAxisID: "incomeAndExpense",
        },
        {
          label: '施設',
          data: each_year_balances.map(&:elderly_facility_amount),
          borderColor: "rgba(247,206,252,1)",
          backgroundColor: "rgba(247,206,252,1)",
          yAxisID: "incomeAndExpense",
        },
        {
          label: 'ライフイベント',
          data: each_year_balances.map(&:life_event_amount),
          borderColor: "rgba(244,181,145,1)",
          backgroundColor: "rgba(244,181,145,1)",
          yAxisID: "incomeAndExpense",
        },
        {
          label: '支出',
          data: each_year_balances.map(&:spending_amount),
          borderColor: "rgba(185,220,138,1)",
          backgroundColor: "rgba(185,220,138,1)",
          yAxisID: "incomeAndExpense",
        },
      ]
    }
  end

  def chart_options
    {
      tooltips: {
        mode: 'nearest',
        intersect: false,
      },
      responsive: true,
      scales: {
        x: {
          stacked: true
        },
        incomeAndExpense: {
          title: {
            display: true,
            text: '収支金額'
          },
          max: 10000000,
          min: -1000000,
          stepSize: 1000000,
          stacked: true
        },
        assets: {
          title: {
            display: true,
            text: '資産金額'
          },
          position: 'right',
          max: 100000000,
          min: -10000000,
          stepSize: 10000000,
        },
      },
    }
  end
end
