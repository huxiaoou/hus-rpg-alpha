extends EnemyAI

class_name EnemyAIValkyrie

func think() -> AIAbilityData:
	print("Valkyrie is thinking")
	var ai_ability_data: AIAbilityData = AIAbilityData.new()
	if try_perform_attack(enemy.director_abilities.get_ability("ability_bow"), ai_ability_data):
		return ai_ability_data
	elif try_perform_move(enemy.director_abilities.get_ability("ability_bow"), ai_ability_data):
		return ai_ability_data
	return null
