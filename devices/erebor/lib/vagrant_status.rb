class VagrantStatus
  attr_reader :state

  def initialize(state)
    @state = state
  end

  # vagrant status --machine-readable
  # 1721851780,erebor,state,not_created
  def self.newFromString(vagrant_status_output)
    state = "unknown"
    vagrant_status_output.each_line do |line|
      lineArray = line.split(",")
      if lineArray[2] == "state"
        state = lineArray[3].strip
      end
    end
    VagrantStatus.new(state)
  end
end
