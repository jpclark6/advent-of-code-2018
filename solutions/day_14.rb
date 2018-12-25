require 'pry'

class Elf
  attr_accessor :loc, :score
  def initialize(loc, score)
    @loc = loc
    @score = score
  end
end

class Recipe
  def find_next_recipe(elf_1, elf_2)
    elf_1.score + elf_2.score
  end

  def find_recipes_after(recipe)
    elf_1 = Elf.new(0, 3)
    elf_2 = Elf.new(1, 7)
    recipes = [3, 7]
    current_length = recipes.length

    until recipes.length > recipe + 11
      next_recipe = find_next_recipe(elf_1, elf_2)

      if next_recipe > 9
        next_recipe_1 = next_recipe.to_s[0].to_i
        next_recipe_2 = next_recipe.to_s[1].to_i
        recipes << next_recipe_1
        recipes << next_recipe_2
      else
        recipes << next_recipe
      end

      current_length = recipes.length
      elf_1.loc = (elf_1.loc + elf_1.score + 1) % current_length
      elf_2.loc = (elf_2.loc + elf_2.score + 1) % current_length
      elf_1.score = recipes[elf_1.loc]
      elf_2.score = recipes[elf_2.loc]
    end

    recipes[recipe..recipe + 9]
  end

  def find_recipe_sequence(input)
    input = input.chars.map { |num| num.to_i }
    input_length = input.length

    elf_1 = Elf.new(0, 3)
    elf_2 = Elf.new(1, 7)
    recipes = [3, 7]
    current_loc = 2

    until recipes[current_loc - input_length] == input[-input_length] && recipes[current_loc + 1 - input_length] == input[-input_length + 1] &&
      recipes[current_loc + 2 - input_length] == input[-input_length + 2] && recipes[current_loc + 3 - input_length] == input[-input_length + 3] &&
      recipes[current_loc + 4 - input_length] == input[-input_length + 4] && recipes[current_loc + 5 - input_length] == input[-input_length + 5] &&
      recipes[current_loc - input_length..current_loc - 1] == input
      next_recipe = find_next_recipe(elf_1, elf_2)

      if next_recipe > 9
        recipes << 1
        current_loc += 1
        if recipes[current_loc - input_length] == input[-input_length] && recipes[current_loc + 1 - input_length] == input[-input_length + 1] &&
            recipes[current_loc + 2 - input_length] == input[-input_length + 2] && recipes[current_loc + 3 - input_length] == input[-input_length + 3] &&
            recipes[current_loc + 4 - input_length] == input[-input_length + 4] && recipes[current_loc + 5 - input_length] == input[-input_length + 5] &&
            recipes[current_loc - input_length..current_loc - 1] == input
            break
        end
        recipes << next_recipe - 10
        current_loc += 1
      else
        recipes << next_recipe
        current_loc += 1
      end

      elf_1.loc = (elf_1.loc + elf_1.score + 1) % current_loc
      elf_2.loc = (elf_2.loc + elf_2.score + 1) % current_loc
      elf_1.score = recipes[elf_1.loc]
      elf_2.score = recipes[elf_2.loc]

      # if current_loc % 1_000_000 == 0
      #   puts "Recipe: #{current_loc}"
      # end

    end
    current_loc - input_length
  end

end

recipe = Recipe.new
puzzle_input = 260321

recipe_scores = recipe.find_recipes_after(puzzle_input)
puts "Solution part 1: #{recipe_scores.map { |num| num.to_s }.join}"

recipe_scores = recipe.find_recipe_sequence("260321")
puts "Solution part 2: #{recipe_scores}"
