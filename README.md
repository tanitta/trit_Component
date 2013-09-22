trit_Component
==============

RigidChipsのためのコンポーネントのドライバつめあわせ(要Equa)

##TCS_typeR.lua
競技車両向けトラクションコントロールシステム  
減算方式で出力を調整する
SorceressR530に搭載  

##ABS_typeR.lua
競技車両向けアンチブレーキロックシステム  
減算方式で出力を調整する
SorceressR530に搭載  

##CA01.lua
カメラモジュール  
幽体離脱でどこまでも

##AE10.lua
trit 航空機用発動機 trit_Component_AE10 "Radiata" Manual (Ver.Equa)

###導入
当製品は全速度、全高度に於いて理論上最高効率を実現するため解析的手法により制御を行う。

###搭載方法
####Main関数, OnFrame関数前の記述

		Eg = trit_Component.AE10:new() --Objectの生成

####Main関数, OnFrame関数内部の記述

		Eg:SetParameter( RLWの回転速度,　RLWのY軸並進速度, Bladeに該当するチップのRLWからの距離 )　
		--RLWのY軸並進速度は前進時に正の数になるよう代入する。 RLWの回転速度の符号は特に指定しない。
		--Bladeに該当するチップのRLWからの距離はデフォルトで0.6，この引数は省略可能である。

		Eg() --内部で演算を行う。
		angEgBlade = Eg:GetAngle() --Bladeの角度を取得する。　なお代入する際、適宜符号を調節する。

###運用条件
1. 高度  大気中(約10000mまで) 
2. 速度  全速度域 
3. Bladeは偶数ならば何枚でも可 

###各種機能
####推力、空気抵抗の調節機能
method "SetPerConvert"に0~1の任意の値を代入することで、推力、空気抵抗の割合を変更する。0を代入した場合、推力0、進行方向の空気抵抗も0となり惰性飛行を行うことが出来る。Default値は1である。

####BladeBrake機能
method "SetPerBladeBrake"に0~1の任意の値を代入することで、Bladeを減速に使用することができる。Default値は0である。

###その他
####角速度の取得について
RC標準関数"_WY(cn)"は得られる値の精度が低いため、他の関数からの算出を推奨する。
