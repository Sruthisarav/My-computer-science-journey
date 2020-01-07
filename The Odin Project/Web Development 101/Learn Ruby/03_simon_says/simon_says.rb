#write your code here
def echo(str)
    return str
end
def shout(str)
    return str.upcase
end
def repeat(str, n=2)
    result = ""
    n.times {result = result + str + " "}
    return result[0...-1]
end
def start_of_word(str, n)
    return str[0...n]
end
def first_word(str)
    return str.split(' ')[0]
end
def titleize(str)
    newStr = []
    str.split(' ').each {|word| newStr << word.capitalize()}
    return newStr.join(' ')
end