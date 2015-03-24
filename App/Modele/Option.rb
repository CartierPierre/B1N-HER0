class Option
	attr_accessor :tuileZero, :tuileUn, :langue	
	
	private_class_method :new

	def Option.creer(tuileZero,tuileUn,langue)
        	new(tuileZero,tuileUn,langue)
    	end

	def initialize(tuileZero,tuileUn,langue)
		@tuileZero, @tuileUn, @langue = tuileZero,tuileUn,langue
	end
end
