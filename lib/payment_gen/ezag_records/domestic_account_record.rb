module PaymentGen
  module EZAGRecords
    class DomesticAccountRecord < Base
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
        (data[:receiver_account_number] || '').gsub(/-/, '').ljust(9)
      end

      def end_beneficiary_account_number
        (data[:end_beneficiary_account_number] || '').ljust(35)
      end

      def receiver_name
        data[:receiver_name].ljust(35, ' ')
      end

      def reference_number
        (data[:reference_number] || '').rjust(27, '0')
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
    end
  end
end
