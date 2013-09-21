--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
--trit_Component_AE10 "Radiata"
--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
--
--trit 航空機用発動機 trit_Component_AE10 "Radiata" Manual (Ver.Equa)
--
--■導入
--	当製品は全速度、全高度に於いて理論上最高効率を実現するため解析的手法により制御を行う。
--
--■搭載方法
--	例
--	□Main関数, OnFrame関数の前に記述すること
--
--		--"■"線で囲った部分を記述する。
--		Eg = trit_Component.AE10:new() --Objectの生成
--
--	□Main関数, OnFrame関数の内部に記述すること
--
--		Eg:SetParameter( RLWの回転速度,　RLWのY軸並進速度, Bladeに該当するチップのRLWからの距離 )　
--		--RLWのY軸並進速度は前進時に正の数になるよう代入する。 RLWの回転速度の符号は特に指定しない。
--		--Bladeに該当するチップのRLWからの距離はデフォルトで0.6，この引数は省略可能である。
--
--		Eg() --内部で演算を行う。
--		angEgBlade = Eg:GetAngle() --Bladeの角度を取得する。　なお代入する際、適宜符号を調節する。
--
--■運用条件
--	高度  大気中(約10000mまで)
--	速度  全速度域
--	Bladeは偶数ならば何枚でも可
--
--■各種機能
--	□推力、空気抵抗の調節機能
--		method "SetPerConvert"に0~1の任意の値を代入することで、
--		推力、空気抵抗の割合を変更する。
--		0を代入した場合、推力0、進行方向の空気抵抗も0となり惰性飛行を行うことが出来る。
--		Default値は1である。
--
--	□BladeBrake機能
--		method "SetPerBladeBrake"に0~1の任意の値を代入することで、
--		Bladeを減速に使用することができる。
--		Default値は0である。
--
--■その他
--	□角速度の取得について
--		RC標準関数"_WY(cn)"は得られる値の精度が低いため、
--		他の関数からの算出を推奨する。
--
--■Log
--Ver.7 2012.06.07 説明を加筆
--Ver.6 2011.08.12 説明を加筆
--Ver.5 2011.03.25 大径プロペラに正式対応　
--Ver.4 2010.11.04 修正版公開　
--	回転速度の符号が乱れるため絶対値で演算するようにした。
--	今後、method SetParameterに代入するRLWの回転速度の符号は任意とする。
--
--Ver.3 2010.11.01 公開

namespace "trit_Component"
{
	concept "IAeroEngine"
	{
		method "GetVer"
		:description "Versionの取得。";

		method "SetParameter"
		:description "第一引数にRLWの回転速度、第二引数にRLWのY軸並進速度、第三引数にプロペラの半径(0.6*プロペラ一枚あたりのチップ数)を代入する。第三引数は省略可(自動的に0.6となる。)";

		method "SetPerConvert"
		:description "推力、空気抵抗の割合を変更する。";

		method "SetPerBladeBrake"
		:description "Bladeを減速に使用する。";

		method "GetAngle"
		:description "Bladeの角度を取得する。";

		metamethod "__call"
		:description "発動機の制御を行う。";
	};
}

namespace "trit_Component"
{
	class  "AE10"
	:implements(trit_Component.IAeroEngine)
	{
		metamethod "_init"
		:body(
			function(self)
				self.ver = 7
				self.m_per_sec_x_Trim = 0
				self.rev_per_sec_y_Wheel = 0
				self.m_per_sec_y_Wheel = 0
				self.m_rad = 0.6
				self.angBlade = 45
				self.perConvert = 1
				self.perBladeBrake = 0

			end
		);

		method "GetVer"
		:body(
			function(self)
				return self.ver
			end
		);

		method "SetParameter"
		:body(
			function(self,w,v,r)
				self.rev_per_sec_y_Wheel = math.abs(w)

				if v > 0 then
					self.m_per_sec_y_Wheel = v
				else
					self.m_per_sec_y_Wheel = 0
				end
				self.m_rad = r or 0.6
				self.m_per_sec_x_Trim = self.rev_per_sec_y_Wheel*self.m_rad
			end
		);

		method "SetPerConvert"
		:body(
			function(self,per)
				self.perConvert = per
			end
		);

		method "SetPerBladeBrake"
		:body(
			function(self,per)
				self.perBladeBrake = per
			end
		);

		method "GetAngle"
		:body(
			function(self)
				return self.angBlade
			end
		);

		metamethod "__call"
		:body(
			function(self)
				self.angBlade = math.deg(math.pi/2+math.atan2(self.m_per_sec_y_Wheel,math.abs(self.m_per_sec_x_Trim)))/(1+self.perConvert)*(1-self.perBladeBrake)
			end
		);
	};
}
--
--■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
