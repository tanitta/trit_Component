namespace "trit_Component"{
	class "CA01"{
		metamethod "_init"
		:body(
			function(self)
				self.cooAx = 0
				self.cooAy = 0
				self.cooAz = 0
				self.cooBx = 0
				self.cooBy = 0
				self.cooBz = 0
				self.angZoom = 0

				self.tabVec = {x = 0, y = 1, z = 0}
			end
		);

		method "SetView"
		:body(
			function(self, ax, ay, az, bx, by, bz)
				self.cooAx = ax
				self.cooAy = ay
				self.cooAz = az
				self.cooBx = bx
				self.cooBy = by
				self.cooBz = bz

			end
		);

		method "SetViewUp"
		:body(
			function(self, yx, yy, yz)
				self.tabVec.x = yx
				self.tabVec.y = yy
				self.tabVec.z = yz
			end
		);

		method "SetZoom"
		:body(
			function(self, ang)
				self.angZoom = ang
			end
		);

		metamethod "__call"
		:body(
			function(self)
				_SETVIEW(self.cooAx,self.cooAy,self.cooAz,self.cooBx,self.cooBy,self.cooBz)
				_SETVIEWZOOM(self.angZoom)
				_SETVIEWUP(self.tabVec.x, self.tabVec.y, self.tabVec.z)
			end
		);
	};
};