class ThreadChrono < Thread

	@chrono 

	attr_reader :chrono

	def initialize()
		super()
		@chrono = Chrono.new()
	end

	def start()
		while(true)
			if(!@chrono.estActif)
	            @temps.set_label(@chrono.to_s)
        	end
        	sleep(0.1)
        end
	end

end           