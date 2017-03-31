describe 'Player actions' do
  context :antidote do
    before do
      subject.apply_antidote
    end

    context Player::Human do
      subject { human }

      it { expect(subject.antidotes).to eq 0 }
      it { expect(subject.role).to be_instance_of Player::Human }
    end

    context Player::TemporaryInfected do
      subject { temp_infected }

      it { expect(subject.antidotes).to eq 0 }
      it { expect(subject.role).to be_instance_of Player::Human }
    end

    context Player::PermanentInfected do
      subject { perm_infected }

      it { expect(subject.antidotes).to eq 0 }
      it { expect(subject.role).to be_instance_of Player::PermanentInfected }
    end

    context Player::Zombie do
      subject { zombie }

      it { expect(subject.antidotes).to eq 0 }
      it { expect(subject.role).to be_instance_of Player::Zombie }
    end
  end

  context :next_turn do
    before do
      subject.update_scores(+5)

      10.times do
        subject.next_turn
      end
    end

    context Player::Human do
      subject { human }

      it { expect(subject.scores).to eq 5 }
      it { expect(subject.role).to be_instance_of Player::Human }
    end

    context Player::TemporaryInfected do
      subject { temp_infected }

      it { expect(subject.scores).to eq 0 }
      it { expect(subject.role).to be_instance_of Player::PermanentInfected }
    end

    context Player::PermanentInfected do
      subject { perm_infected }

      it { expect(subject.scores).to eq 5 }
      it { expect(subject.role).to be_instance_of Player::PermanentInfected }
    end

    context Player::Zombie do
      subject { zombie }

      it { expect(subject.scores).to eq 5 }
      it { expect(subject.role).to be_instance_of Player::Zombie }
    end
  end
end
