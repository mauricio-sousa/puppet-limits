require 'spec_helper'
describe 'limits::limit', :type => :define do
	let(:title)    { 'username_nofile' }
	let(:filename) { '/etc/security/limits.d/username_nofile.conf' }

	let :facts do
		{
			:osfamily => 'Debian'
		}
	end

	let :params do
		{
			:ensure     => 'present',
			:user       => 'username',
			:limit_type => {
				'nofile' => {
					'soft' => 16384,
					'hard' => 32768,
				}
			}
		}
	end

	describe "when creating a limits entry NOT ending in .conf with multiple limit types" do
		let(:title)    { 'username_nofile_nproc' }
		let(:filename) { '/etc/security/limits.d/username_nofile_nproc.conf' }

		let :params do
			{
				:ensure     => 'present',
				:user       => 'username',
				:limit_type => {
					'nofile' => {
						'soft' => 16384,
						'hard' => 32768,
					},
					'nproc' => {
						'soft' => 16384,
						'hard' => 32768,
					}
				}
			}
		end

		it { should contain_limits__limit('username_nofile_nproc').with({
			:ensure     => 'present',
			:user       => 'username',
			:limit_type => {
				'nofile' => {
					'soft' => 16384,
					'hard' => 32768,
				},
				'nproc' => {
					'soft' => 16384,
					'hard' => 32768,
				}
			}
		})
	}

	it { should contain_file(filename).with({
		'ensure'    => 'present',
		'content'   => "#\n# This file is managed by Puppet. DO NOT EDIT.\n#\n\nusername    soft    nofile    16384\nusername    hard    nofile    32768\n\nusername    soft    nproc    16384\nusername    hard    nproc    32768\n\n",
		'owner'     => 'root',
		'group'     => 'root',
	})
}
end

describe "when creating a limits entry NOT ending in .conf" do

	it { should contain_limits__limit('username_nofile').with({
		:ensure     => 'present',
		:user       => 'username',
		:limit_type => {
			'nofile' => {
				'soft' => 16384,
				'hard' => 32768,
			}
		}
	})
}

it { should contain_file(filename).with({
	'ensure'    => 'present',
	'content'   => "#\n# This file is managed by Puppet. DO NOT EDIT.\n#\n\nusername    soft    nofile    16384\nusername    hard    nofile    32768\n\n",
	'owner'     => 'root',
	'group'     => 'root',
})
}
end

describe "when creating a limits entry with one limit type" do

	let :params do
		{
			:ensure     => 'present',
			:user       => 'username',
			:limit_type => {
				'nofile' => {
					'soft' => 16384,
				}
			}
		}
	end

	it { should contain_limits__limit('username_nofile').with({
		:ensure     => 'present',
		:user       => 'username',
		:limit_type => {
			'nofile' => {
				'soft' => 16384
			}
		}
	})
}

it { should contain_file(filename).with({
	'ensure'    => 'present',
	'content'   => "#\n# This file is managed by Puppet. DO NOT EDIT.\n#\n\nusername    soft    nofile    16384\n\n",
	'owner'     => 'root',
	'group'     => 'root',
})
}
end

describe "when creating a limits entry with group" do

	let :params do
		{
			:ensure     => 'present',
			:user       => '@student',
			:limit_type => {
				'nofile' => {
					'soft' => 16384,
				}
			}
		}
	end

	it { should contain_limits__limit('username_nofile').with({
		:ensure     => 'present',
		:user       => '@student',
		:limit_type => {
			'nofile' => {
				'soft' => 16384
			}
		}
	})
}

it { should contain_file(filename).with({
	'ensure'    => 'present',
	'content'   => "#\n# This file is managed by Puppet. DO NOT EDIT.\n#\n\n@student    soft    nofile    16384\n\n",
	'owner'     => 'root',
	'group'     => 'root',
})
}
end

describe "when creating a limits entry ending in .conf" do

	let(:title)    { 'username_nofile.conf' }

	it { should contain_limits__limit('username_nofile.conf').with({
		:ensure     => 'present',
		:user       => 'username',
		:limit_type => {
			'nofile' => {
				'soft' => 16384,
				'hard' => 32768,
			}
		}
	})
}

it { should contain_file(filename).with({
	'ensure'    => 'present',
	'content'   => "#\n# This file is managed by Puppet. DO NOT EDIT.\n#\n\nusername    soft    nofile    16384\nusername    hard    nofile    32768\n\n",
	'owner'     => 'root',
	'group'     => 'root',
})
}
end

describe "when removing an limits entry" do
	let :params do
		{
			:ensure     => 'absent',
			:user       => 'username',
			:limit_type => {
				'nofile' => {
					'soft' => 16384,
					'hard' => 32768,
				}
			}
		}
	end

	it { should contain_file(filename).with({
		'ensure'    => 'absent',
		'content'   => "#\n# This file is managed by Puppet. DO NOT EDIT.\n#\n\nusername    soft    nofile    16384\nusername    hard    nofile    32768\n\n",
		'owner'     => 'root',
		'group'     => 'root',
	})
}
end

end