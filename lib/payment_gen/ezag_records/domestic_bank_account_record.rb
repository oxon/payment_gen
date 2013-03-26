module PaymentGen
  module EZAGRecords
    class DomesticBankAccountRecord < DomesticAccountRecord
      def transaction_type
        '27'
      end

      def receiver_bank
        (data[:receiver_bank] || '').ljust(35, ' ')
      end

      def receiver_bank_description
        (data[:receiver_bank_description] || '').ljust(35, ' ')
      end

      def receiver_bank_street
        (data[:receiver_bank_street] || '').ljust(35, ' ')
      end

      def receiver_bank_zip_code
        (data[:receiver_bank_zip_code] || '').ljust(10, ' ')
      end

      def receiver_bank_city
        (data[:receiver_bank_city] || '').ljust(25, ' ')
      end

      def to_s
        "036#{due_date}000001#{account_number}#{account_number}01#{transaction_type}#{transaction_number}0000000#{main_section}".ljust(700, ' ')
      end

      def main_section
        "#{source_currency}#{payment_amount} #{target_currency}#{land_code}#{receiver_account_number}      #{end_beneficiary_account_number}#{receiver_bank}#{receiver_bank_description}#{receiver_bank_street}#{receiver_bank_zip_code}#{receiver_bank_city}#{receiver_name}#{additional_identification}#{receiver_street}#{receiver_zip_code}#{receiver_city}"
      end
    end
  end
end
