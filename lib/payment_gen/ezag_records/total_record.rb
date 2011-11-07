module PaymentGen
  module EZAGRecords
    class TotalRecord < Base

      def transaction_type
        '97'
      end

      def transaction_number
        number = data[:totals].inject(0) do |sum, total|
          sum += total[1][:transactions]
        end + 1
        number.to_s.rjust(6, '0')
      end

      def to_s
        "036#{due_date}000001#{account_number}#{account_number}01#{transaction_type}#{transaction_number}0000000#{main_section}"
      end

      def main_section
        result = ''
        data[:totals].each do |currency, info|
          number_of_transactions = info[:transactions].to_s.rjust(6, '0')
          amount = sprintf('%.2f', info[:total]).gsub(/\./, '').rjust(13, '0')
          result << "#{currency}#{number_of_transactions}#{amount}"
        end
        result.ljust(15 * 22, '0') + (' ' * 320)
      end

    end
  end
end
