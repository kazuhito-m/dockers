#!/bin/bash

# �ȈՂȁu�T�[�o��Chef������܂Łv�Ƃ����X�N���v�g���܂Ƃ߂�B
# (Chef�ȍ~��Chef���ɂ܂�����)
#
# ���ɗ͊y����̂ŁA�{���͗ǂ��Ȃ���yum�Ɉˑ�������A���낢��؂̈������Ƃ����Ă���̂͏��m�̏�B
#
# �Ώ�:CentOS7
# user:root
# ���dir:�C��
#

# TODO �K�v�Ƃ���΂����Ɋ��̑O����(Proxy�Ƃ�)

# Ruby�ŐV�C���X�g�[��(���|�W�g���C��)
yum install -y ruby git

# Chef�C���X�g�[��(���[�U��root�O��B��ʃ��[�U�Ȃ�sudo�t����)
curl http://www.opscode.com/chef/install.sh | bash

# ���|�W�g���̍쐬�B
git clone http://github.com/opscode/chef-repo.git

# �N�b�N�u�b�N�̍쐬�B
knife configure
