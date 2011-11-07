module PaymentGen
  module EZAGRecords
    class DomesticPostAccountRecord < Base

      def transaction_type
        '22'
      end

      def source_currency
        data[:source_currency]
      end

      def payment_amount
        sprintf('%.2f', data[:payment_amount]).gsub(/\./, '').rjust(13, '0')
      end

      def native_payment_amount
        data[:payment_amount]
      end

      def target_currency
        data[:target_currency]
      end

      def land_code
        data[:land_code]
      end

      def receiver_account_number
        data[:receiver_account_number].gsub(/-/, '')
      end

      def end_beneficiary_account_number
        data[:end_beneficiary_account_number]
      end

      def receiver_name
        data[:receiver_name].ljust(35, ' ')
      end

      def additional_identification
        (data[:additional_identification] || '').ljust(35, ' ')
      end

      def receiver_street
        (data[:receiver_street] || '').ljust(35, ' ')
      end

      def receiver_zip_code
        (data[:receiver_zip_code] || '').ljust(10, ' ')
      end

      def receiver_city
        (data[:receiver_city] || '').ljust(25, ' ')
      end

      def to_s
        "036#{due_date}000001#{account_number}#{account_number}01#{transaction_type}#{transaction_number}0000000#{main_section}"
      end

      def main_section
        "#{source_currency}#{payment_amount} #{target_currency}#{land_code}#{receiver_account_number}      #{end_beneficiary_account_number}#{receiver_name}#{additional_identification}#{receiver_street}#{receiver_zip_code}#{receiver_city}#{' ' * 438}"
      end

    end
  end
end
