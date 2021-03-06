require 'date'

module PaymentGen
  module EZAGRecords
    class Base

      attr_reader :data

      def initialize(data)
        @data = data
      end

      def due_date
        begin
          Date.parse(data[:due_date]).strftime('%y%m%d')
        rescue
          '000000'
        end
      end

      def account_number
        data[:account_number].gsub(/-/, '')
      end

      def transaction_type
        '00'
      end

      def transaction_number=(value)
        @transaction_number = value
      end

      def transaction_number
        (@transaction_number || 0).to_s.rjust(6, '0')
      end

    end
  end
end
