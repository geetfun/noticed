module Noticed
  module DeliveryMethods
    class MessageBus < Base

      def deliver
        ::MessageBus.publish "/#{channel}", format, client_ids: client_ids, user_ids: user_ids, group_ids: group_ids
      end

      private

      def format
        if (method = options[:format])
          notification.send(method)
        else
          notification.params
        end
      end

      def client_ids
        if (method = options[:client_ids])
          notification.send(method)
        else
          []
        end
      end

      def user_ids
        if (method = options[:user_ids])
          notification.send(method)
        else
          []
        end
      end

      def group_ids
        if (method = options[:group_ids])
          notification.send(method)
        else
          []
        end
      end

      def channel
        @channel ||= begin
           value = options[:channel]
           case value
           when String
             value.constantize
           when Symbol
             notification.send(value)
           when Class
             value
           else
             "noticed"
           end
         end
      end

    end
  end
end
