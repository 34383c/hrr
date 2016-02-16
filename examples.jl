using hrr

println("####### START OF EXAMPLES #######\n")

# array of examples? (to easily enumerate them?)
println("Example 1.  Given a vector x = [1, 2, 3, 4, 5], the involution of x ",
        "should return the vector x_bar = [1, 5, 4, 3, 2].")
hrr.invol([1, 2, 3, 4, 5], debug=true)

println("\n######## END OF EXAMPLES ########")
