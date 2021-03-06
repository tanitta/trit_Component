namespace "trit_Component"{
	class "ABS_typeR"{
		metamethod "_init"
		:body(
			function(self,r)
				self.version = 20
				self.parTs = 1--Power係数
				self.k = 5
				self.s = 0.02
				self.r = r--半径

			end
		);

		method "SetInput"
		:body(
			function(self, vel, angvel )
				self.tp = angvel/vel
				self.tp = -vel +angvel * 0.3*1.5

			end
		);

		method "GetOutput"
		:body(
			function(self)
				return self.parTs
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
				local k=1.5
				--係数 数が大きいほど効果大
				local s=0.02
				--fl

				if self.tp<-self.k then
					self.parTs = limit( self.parTs *(1-self.s) , 0.2, 1 )
				else
					self.parTs = limit( self.parTs *(1+self.s) , 0.2, 1 )
				end
				
				self.parTs = limit(1.1- self.tp/54, 0, 1)
			end
		);
	};
}