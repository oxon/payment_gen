module PaymentGen
  module EZAGRecords
    class DomesticPostAccountRecord < DomesticAccountRecord
      def transaction_type
        '22'
      end

      def to_s
        "036#{due_date}000001#{account_number}#{account_number}01#{transaction_type}#{transaction_number}0000000#{main_section}".ljust(700, ' ')
      end

      def main_section
        "#{source_currency}#{payment_amount} #{target_currency}#{land_code}#{receiver_account_number}      #{end_beneficiary_account_number}#{receiver_name}#{additional_identification}#{receiver_street}#{receiver_zip_code}#{receiver_city}"
      end
    end
  end
end
