module Admin
  class SystemConfigsController < ::Admin::MasterController
    def index
      redirect_to edit_admin_system_config_path(find_object)
    end

    def update
      # TODO: 重要項目移行時に履歴管理するように変更
      super
    end

    def test_send_sms
      find_object
      @system_config.assign_attributes(admin_object_params)
      sms_result = @system_config.sms_results.build(
        tel: @system_config.test_sms_tel,
        text_body: "疎通テスト:#{Time.current}"
      ).to_deliverer
      render_javascript do |page|
        if @system_config.sms_use.unavailable?
          ret = false
          msg = 'SMS接続先設定の設定を行ってください'
        else
          ret, response_opt = sms_result.safe_deliver(target_config: @system_config)
          msg = response_opt.dig(:err_message, :messege)
        end

        if ret
          cnt = 0
          while true
            ret, response_opt = sms_result.check_result(target_config: @system_config)
            if sms_result.status.send?
              page.alert('接続OK', { sub: sms_result.result_messege.gsub("\n", ' | '), mode: :success })
              break
            end
            if cnt > 1
              page.alert('接続NG', { sub: '結果が取得できません', mode: :error })
              break
            end
            cnt += 1
            sleep(3)
          end
        else
          page.alert('接続NG', { sub: msg, mode: :error })
        end
      end
    rescue StandardError => e
      LoggerService.new(exception: e, request:).call
    ensure
      sms_result.safe_destroy if sms_result&.exists_db?
    end

    def find_object
      @system_config = SystemConfig.target_record
    end
  end
end
