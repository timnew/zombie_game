describe 'Player interactions' do
  before do
    subject.interact(object)
  end

  context 'human interact with human' do
    subject { human }
    let(:object) { human }

    it { expect(subject.scores).to eq 1 }
    it { expect(object.scores).to eq 1 }
    it { expect(subject.role).to be_instance_of Player::Human }
    it { expect(object.role).to be_instance_of Player::Human }
  end

  context 'human interact with temp infected' do
    subject { human }
    let(:object) { temp_infected }

    it { expect(subject.scores).to eq 0 }
    it { expect(object.scores).to eq 0 }
    it { expect(subject.role).to be_instance_of Player::TemporaryInfected }
    it { expect(object.role).to be_instance_of Player::TemporaryInfected }
  end

  context 'temp infected interact with human' do
    subject { temp_infected }
    let(:object) { human }

    it { expect(subject.scores).to eq 0 }
    it { expect(object.scores).to eq 0 }
    it { expect(subject.role).to be_instance_of Player::TemporaryInfected }
    it { expect(object.role).to be_instance_of Player::TemporaryInfected }
  end

  context 'human interact with perm infected' do
    subject { human }
    let(:object) { perm_infected }

    it { expect(subject.scores).to eq 0 }
    it { expect(object.scores).to eq 1 }
    it { expect(subject.role).to be_instance_of Player::TemporaryInfected }
    it { expect(object.role).to be_instance_of Player::PermanentInfected }
  end

  context 'perm infected interact with human' do
    subject { perm_infected }
    let(:object) { human }

    it { expect(subject.scores).to eq 1 }
    it { expect(object.scores).to eq 0 }
    it { expect(subject.role).to be_instance_of Player::PermanentInfected }
    it { expect(object.role).to be_instance_of Player::TemporaryInfected }
  end

  context 'human interact with zombie' do
    subject { human }
    let(:object) { zombie }

    it { expect(subject.scores).to eq 0 }
    it { expect(object.scores).to eq 1 }
    it { expect(subject.role).to be_instance_of Player::TemporaryInfected }
    it { expect(object.role).to be_instance_of Player::Zombie }
  end

  context 'zombie interact with human' do
    subject { zombie }
    let(:object) { human }

    it { expect(subject.scores).to eq 1 }
    it { expect(object.scores).to eq 0 }
    it { expect(subject.role).to be_instance_of Player::Zombie }
    it { expect(object.role).to be_instance_of Player::TemporaryInfected }
  end

  context 'temp infected interact with temp infected' do
    subject { temp_infected }
    let(:object) { temp_infected }

    it { expect(subject.scores).to eq 0 }
    it { expect(object.scores).to eq 0 }
    it { expect(subject.role).to be_instance_of Player::TemporaryInfected }
    it { expect(object.role).to be_instance_of Player::TemporaryInfected }
  end

  context 'temp infected interact with perm infected' do
    subject { temp_infected }
    let(:object) { perm_infected }

    it { expect(subject.scores).to eq 0 }
    it { expect(object.scores).to eq 0 }
    it { expect(subject.role).to be_instance_of Player::TemporaryInfected }
    it { expect(object.role).to be_instance_of Player::PermanentInfected }
  end

  context 'perm infected interact with temp infected' do
    subject { perm_infected }
    let(:object) { temp_infected }

    it { expect(subject.scores).to eq 0 }
    it { expect(object.scores).to eq 0 }
    it { expect(subject.role).to be_instance_of Player::PermanentInfected }
    it { expect(object.role).to be_instance_of Player::TemporaryInfected }
  end

  context 'temp infected interact with zombie' do
    subject { temp_infected }
    let(:object) { zombie }

    it { expect(subject.scores).to eq 0 }
    it { expect(object.scores).to eq 0 }
    it { expect(subject.role).to be_instance_of Player::TemporaryInfected }
    it { expect(object.role).to be_instance_of Player::Zombie }
  end

  context 'zombie interact with temp infected' do
    subject { zombie }
    let(:object) { temp_infected }

    it { expect(subject.scores).to eq 0 }
    it { expect(object.scores).to eq 0 }
    it { expect(subject.role).to be_instance_of Player::Zombie }
    it { expect(object.role).to be_instance_of Player::TemporaryInfected }
  end

  context 'perm infected interact with perm infected' do
    subject { perm_infected }
    let(:object) { perm_infected }

    it { expect(subject.scores).to eq 0 }
    it { expect(object.scores).to eq 0 }
    it { expect(subject.role).to be_instance_of Player::PermanentInfected }
    it { expect(object.role).to be_instance_of Player::PermanentInfected }
  end

  context 'perm infected interact with zombie' do
    subject { perm_infected }
    let(:object) { zombie }

    it { expect(subject.scores).to eq 0 }
    it { expect(object.scores).to eq 0 }
    it { expect(subject.role).to be_instance_of Player::PermanentInfected }
    it { expect(object.role).to be_instance_of Player::Zombie }
  end

  context 'zombie interact with perm infected' do
    subject { zombie }
    let(:object) { perm_infected }

    it { expect(subject.scores).to eq 0 }
    it { expect(object.scores).to eq 0 }
    it { expect(subject.role).to be_instance_of Player::Zombie }
    it { expect(object.role).to be_instance_of Player::PermanentInfected }
  end

  context 'zombie interact with zombie' do
    subject { zombie }
    let(:object) { zombie }

    it { expect(subject.scores).to eq 0 }
    it { expect(object.scores).to eq 0 }
    it { expect(subject.role).to be_instance_of Player::Zombie }
    it { expect(object.role).to be_instance_of Player::Zombie }
  end
end
