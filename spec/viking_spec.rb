require 'viking'

describe Viking do

  let(:viking){Viking.new("Joey", 99)}

  describe "#initialize" do

    it 'should be able to accept a name' do
      expect(viking.name).to eq("Joey")
    end

    it 'should be able to have a settable health' do
      expect(viking.health).to eq(99)
    end

    it 'should have unmodifyable health' do
      expect(viking).not_to respond_to(:health=)
    end

    it 'should start with nil weapon' do
      expect(viking.weapon).to be_nil
    end

  end

  describe "#pick_up_weapon" do

    it 'should be able to pick up weapons' do
      expect(viking.weapon).to be_nil
      viking.pick_up_weapon(Bow.new)
      expect(viking.weapon).to be_a(Bow)
    end

    it 'should not be able to pick up strings' do
      expect{viking.pick_up_weapon("Machete")}.to raise_error
    end

    it 'should be able to pick up a new weapon' do
      viking.pick_up_weapon(Axe.new)
      expect(viking.weapon).to be_a(Axe)
      viking.pick_up_weapon(Bow.new)
      expect(viking.weapon).to be_a(Bow)
    end
  end

  describe "#drop_weapon" do

    it 'should be able to drop_weapon' do
      new_viking = Viking.new("Joey", 99, 10, Bow.new)
      expect(new_viking.weapon).to be_a(Bow)
      new_viking.drop_weapon
      expect(new_viking.weapon).to be_nil
    end
  end

  describe "#receive_attack" do

    it 'should take damage when receiving attack' do
      expect(viking).to receive(:take_damage)
      viking.receive_attack(5)
    end

    it 'should lose health when receiving attack' do
      viking.receive_attack(5)
      expect(viking.health).to eq(94)
    end
  end

  describe "#attack" do

    let(:viking_attacker) {Viking.new("Boxer", 204, 80)}
    let(:viking_defender) {Viking.new("Sandbag", 405, 2)}

    it 'should reduce the defenders health when attacking' do
      viking_attacker.attack(viking_defender)
      expect(viking_defender.health).to eq(385)
    end

    it 'should call defenders take damage method' do
      expect(viking_defender).to receive(:take_damage)
      viking_attacker.attack(viking_defender)
    end

    it 'should call "damage with fists" when there is no weapon' do
      expect(viking_attacker).to receive(:damage_with_fists).and_return(30)
      viking_attacker.attack(viking_defender)
      expect(viking_defender.health).to eq(375)
    end

    it 'should deal proper damage when there is no weapon' do
      viking_attacker.attack(viking_defender)
      expect(viking_defender.health).to eq(385)
    end

    context 'weapons' do
      let(:viking_axeman) {Viking.new("Axeman", 100, 10, Axe.new)}
      let(:viking_archer) {Viking.new("Bowman", 100, 10, Bow.new(3))}

      it 'should call "damage with weapon when there is a weapon' do
        expect(viking_axeman).to receive(:damage_with_weapon).and_return(5)
        viking_axeman.attack(viking_defender)
        expect(viking_defender.health).to eq(400)
      end

      it 'should deal damage equal to the attacker strength times the weapon multiplier (axe)' do
        viking_axeman.attack(viking_defender)
        expect(viking_defender.health).to eq(395)
      end

      it 'should deal damage equal to the attacker strength times the weapon multiplier (bow)' do
        viking_archer.attack(viking_defender)
        expect(viking_defender.health).to eq(385)
      end

      it 'should use fists instead of bow if out of ammo' do
        3.times do
          viking_archer.attack(viking_defender)
        end

        expect(viking_defender.health).to eq(345)

        viking_archer.attack(viking_defender)

        expect(viking_defender.health).to eq(342.5)
      end

    end

    context 'killing viking' do

      it 'should raise error when dying' do
        20.times do
          viking_attacker.attack(viking_defender)
        end

        expect{viking_attacker.attack(viking_defender)}.to raise_error("Sandbag has Died...")
      end
    end
  end
end