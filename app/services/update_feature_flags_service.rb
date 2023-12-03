class UpdateFeatureFlagsService
  def initialize(params)
    @feature_params = params
    puts "+++++++++++++++++++++++++++++++++++++"
    puts "+++++++++++++++++  INIT +++++++++++++"
    puts "+++++++++++++++++++++++++++++++++++++"

  end

  def call
    Flipper.features.each do |feature|
      feature_name = feature.name
      is_enabled   = @feature_params["#{feature_name}_enabled"].to_s == "1"

      if feature_name == :sandbox_mode 
        if is_enabled
          puts "+++++++++++++++++  sandbox_mode_enabled +++++++++++++"
          # ActiveRecord::Base.transaction
          # ActiveRecord::Base.connection.execute("SAVEPOINT active_record_1")
          # ActiveRecord::Base.connection.begin_transaction(joinable: false)
          # @transaction_manager = ActiveRecord::Base.connection.transaction_manager
          # @transaction_manager.begin_transaction
          # ActiveRecord::ConnectionAdapters::Savepoints.create_savepoint("SP1")
        else
          puts "----------------- sandbox_mode_disabled -------------"
          # ActiveRecord::ConnectionAdapters::Savepoints.exec_rollback_to_savepoint("SP1")
          # ActiveRecord::Base.connection.rollback_transaction
          # ActiveRecord::Rollback
          # @transaction_manager.rollback_transaction
          # ActiveRecord::Base.connection.execute("ROLLBACK TO SAVEPOINT active_record_1")
        end
      end  

      Flipper.public_send((is_enabled ? "enable" : "disable").to_s, feature_name)
    end
  end
end
