require 'Benchmark'
# 2. Сколько здесь вариантов?
#
# Напишите метод combination для поиска сочетаний в массиве элементов. Сравните производительность метода с одноимённым методом Ruby из класса Array при помощи модуля Benchmark. Пример:
#
# Встроенный метод рассчета комбинаций
elements = [:one, :two, :three, :four]
# combination elements, 2 # => [[:one, :two], [:one, :three], [:one, :four], [:two, :three], [:two, :four], [:three, :four]]
#
# В качестве дополнительной тренировки модифицируйте ваш метод таким образом, чтобы он принимал переменное количество аргументов:
#
# combination :one, :two, :three, :four, group_size: 2

# Встроенный метод рассчета комбинаций:
p elements.combination(2).to_a

# Рассчет комбинаций в цикле:
def comb *elements,group_size:2
  k = elements.count
  combinations = []
  i,j = 0
  while i <= (k-group_size)
    j = i+1
    while j < k
      combinations.push([elements[i],elements[j]])
      j+=1
    end
    i+=1
  end
  combinations
end
p comb :one, :two, :three, :four

# Рекурсивный метод расчета комбинаций
def comb_rec(a,n)
  combin = []
  if n == 1
    for m in a
      combin.push([m])
    end
    combin
  else
    com = comb_rec(a,n-1)
    com.delete_at(-1)
    for j in com #b_rec(a,n-1)
      k = a.index(j[-1])+1
      while k < a.count
        newelement=[]+j
        combin.push(newelement.push(a[k]))
        k +=1
      end
    end
    combin
  end
end
p comb_rec(elements,2)

Benchmark.bm(20) do |bm|

  bm.report("combination") do
    10_000.times{elements.combination(2).to_a}
  end

  bm.report("cycle") do
    10_000.times{comb :one, :two, :three, :four}
  end
  bm.report("recurcion") do
    10_000.times{comb_rec(elements,2)}
  end
end
