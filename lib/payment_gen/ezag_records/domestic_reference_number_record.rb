module PaymentGen
  module EZAGRecords
    class DomesticReferenceNumberRecord < DomesticAccountRecord
      def transaction_type
        '28'
      end

      def message_1
        (data[:message_1] || '').ljust(35, ' ')
      end

      def message_2
        (data[:message_2] || '').ljust(35, ' ')
      end

      def message_3
        (data[:message_3] || '').ljust(35, ' ')
      end

      def message_4
        (data[:message_4] || '').ljust(35, ' ')
      end

      def to_s
        ("036#{due_date}000001#{account_number}#{account_number}01#{transaction_type}#{transaction_number}0000000#{main_section}".ljust(402, ' ')).ljust(700)
      end

      def main_section
        "#{source_currency}#{payment_amount} #{target_currency}#{land_code}  #{receiver_account_number}#{reference_number}#{receiver_name}"
      end
    end
  end
end
