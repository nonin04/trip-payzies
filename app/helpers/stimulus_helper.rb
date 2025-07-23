module StimulusHelper
  # バリデーションエラー用メッセージのJSON
  def stimulus_error_messages_json
    {
      failed: t("stimulus.errors.falied"),
      required: t("stimulus.errors.required"),
      memberRequired: t("stimulus.errors.member_required"),
      participantRequired: t("stimulus.errors.participant_required"),
      maxLength15: t("stimulus.errors.max_length_15"),
      maxLength25: t("stimulus.errors.max_length_25"),
      duplicated: t("stimulus.errors.duplicated"),
      selectRequired: t("stimulus.errors.select_required"),
      invalidAmount: t("stimulus.errors.invalid_amount"),
      maxAmount: t("stimulus.errors.max_amount")
    }.to_json.html_safe
  end
end
