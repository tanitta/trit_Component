--��������������������������������������������������������������������������������
--��������������������������������������������������������������������������������
--trit_Component_AE10 "Radiata"
--��������������������������������������������������������������������������������
--��������������������������������������������������������������������������������
--��������������������������������������������������������������������������������
--��������������������������������������������������������������������������������
--
--trit �q��@�p�����@ trit_Component_AE10 "Radiata" Manual (Ver.Equa)
--
--������
--	�����i�͑S���x�A�S���x�ɉ����ė��_��ō��������������邽�߉�͓I��@�ɂ�萧����s���B
--
--�����ڕ��@
--	��
--	��Main�֐�, OnFrame�֐��̑O�ɋL�q���邱��
--
--		--"��"���ň͂����������L�q����B
--		Eg = trit_Component.AE10:new() --Object�̐���
--
--	��Main�֐�, OnFrame�֐��̓����ɋL�q���邱��
--
--		Eg:SetParameter( RLW�̉�]���x,�@RLW��Y�����i���x, Blade�ɊY������`�b�v��RLW����̋��� )�@
--		--RLW��Y�����i���x�͑O�i���ɐ��̐��ɂȂ�悤�������B RLW�̉�]���x�̕����͓��Ɏw�肵�Ȃ��B
--		--Blade�ɊY������`�b�v��RLW����̋����̓f�t�H���g��0.6�C���̈����͏ȗ��\�ł���B
--
--		Eg() --�����ŉ��Z���s���B
--		angEgBlade = Eg:GetAngle() --Blade�̊p�x���擾����B�@�Ȃ��������ہA�K�X�����𒲐߂���B
--
--���^�p����
--	���x  ��C��(��10000m�܂�)
--	���x  �S���x��
--	Blade�͋����Ȃ�Ή����ł���
--
--���e��@�\
--	�����́A��C��R�̒��ߋ@�\
--		method "SetPerConvert"��0~1�̔C�ӂ̒l�������邱�ƂŁA
--		���́A��C��R�̊�����ύX����B
--		0���������ꍇ�A����0�A�i�s�����̋�C��R��0�ƂȂ�Đ���s���s�����Ƃ��o����B
--		Default�l��1�ł���B
--
--	��BladeBrake�@�\
--		method "SetPerBladeBrake"��0~1�̔C�ӂ̒l�������邱�ƂŁA
--		Blade�������Ɏg�p���邱�Ƃ��ł���B
--		Default�l��0�ł���B
--
--�����̑�
--	���p���x�̎擾�ɂ���
--		RC�W���֐�"_WY(cn)"�͓�����l�̐��x���Ⴂ���߁A
--		���̊֐�����̎Z�o�𐄏�����B
--
--��Log
--Ver.7 2012.06.07 ���������M
--Ver.6 2011.08.12 ���������M
--Ver.5 2011.03.25 ��a�v���y���ɐ����Ή��@
--Ver.4 2010.11.04 �C���Ō��J�@
--	��]���x�̕���������邽�ߐ�Βl�ŉ��Z����悤�ɂ����B
--	����Amethod SetParameter�ɑ������RLW�̉�]���x�̕����͔C�ӂƂ���B
--
--Ver.3 2010.11.01 ���J

namespace "trit_Component"
{
	concept "IAeroEngine"
	{
		method "GetVer"
		:description "Version�̎擾�B";

		method "SetParameter"
		:description "��������RLW�̉�]���x�A��������RLW��Y�����i���x�A��O�����Ƀv���y���̔��a(0.6*�v���y���ꖇ������̃`�b�v��)��������B��O�����͏ȗ���(�����I��0.6�ƂȂ�B)";

		method "SetPerConvert"
		:description "���́A��C��R�̊�����ύX����B";

		method "SetPerBladeBrake"
		:description "Blade�������Ɏg�p����B";

		method "GetAngle"
		:description "Blade�̊p�x���擾����B";

		metamethod "__call"
		:description "�����@�̐�����s���B";
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
--��������������������������������������������������������������������������������
