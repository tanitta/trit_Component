namespace "trit_Component"{
	class "TCS_typeR"{
		metamethod "_init"
		:body(
			function(self,r)
				self.version = 20
				self.parTs = 1--Power係数
				self.k = 8
				self.s = 0.1
				self.r = r--半径

				self.vel = 0
				self.angvel = 0
			end
		);

		method "SetInput"
		:body(
			function(self, vel, angvel )

				self.vel = vel
				self.angvel = angvel
				self.tp = math.abs(-self.vel +self.angvel * 0.3*1.5)
			end
		);

		method "GetOutput"
		:body(
			function(self)
				return self.parTs
			end
		);

		method "GetSlip"
		:body(
			function(self)
				return self.vel -self.angvel * 0.3*1.5
			end
		);

		method "SetParameter"
		:body(
			function(self,k ,s )
				self.k = k
				self.s = s

			end
		);
		metamethod "__call"
		:body(
			function(self)
				--しきい
				--local k=0
				--係数 数が大きいほど効果大
				--local s=0
				--fl
				--self.s = self.tp^-1
				--[[
				if self.tp>self.k then
					self.parTs = limit( self.parTs *(1-self.s) , 0.5, 1 )
				else
					self.parTs = 1--limit( self.parTs *(1+self.s) , 0.2, 1 )
				end
				--self.parTs = 1
				--]]
				
				--self.parTs = 1 --limit( self.parTs+(4-self.tp)*0.1, 0, 1 )
				
				self.parTs = limit(1.1- self.tp/54, 0.1, 2)
				out(16,self.tp)
			end
		);
	};
}