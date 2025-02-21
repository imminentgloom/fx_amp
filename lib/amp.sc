// Fx_Amp

FxAmp : FxBase {

	*new {
		var ret = super.newCopyArgs(nil, \none, (
			in_mult: 1,
         env_sens: 1,
			env_decay: 0.999,
			env_mult: 1,
			amp_mult: 1,
         dry_mult: 0,
         wet_mult: 1
			
		), nil, 1);
		^ret;
	}

	*initClass {
		FxSetup.register(this.new);
	}

	subPath {
		^"/fx_amp";
	}

	symbol {
		^\FxAmp;
	}

	addSynthdefs {
		SynthDef(\FxAmp, {|inBus, outBus|
            			
			// mix two inputs so "insert" mode picks up the nb_voice and live input
         // live input * 2 to match levels (idk why)
         var input = Mix.ar([In.ar(inBus, 2), SoundIn.ar([0, 1]) * 2]);
			
			var follow = EnvFollow.ar(input * \env_sens.kr(1), \env_decay.kr(0.999));
				
			var output = ((input * \in_mult.kr(1) + (follow * \env_mult.kr(1))) * \amp_mult.kr(1)).tanh;
				
			Out.ar(outBus, (input * \dry_mult.kr(0)) + (output * \wet_mult.kr(1)) * 0.5);

		}).add;
	}

}
