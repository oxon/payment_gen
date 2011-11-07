module PaymentGen
  module EZAGRecords
    class HeadRecord < Base

      def transaction_type
        '00'
      end

      def transaction_number
        '000000'
      end

      def main_section
        ' ' * 650
      end

      def to_s
        "036#{due_date}000001#{account_number}#{account_number}01#{transaction_type}#{transaction_number}0000000#{main_section}"
      end

    end
  end
end
