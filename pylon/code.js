function string_to_int_array(str){
        const intArr = [];

        for(let i=0;i<str.length;i++){
          const charcode = str.charCodeAt(i);
          
          const partA = Math.floor(charcode / 26);
          const partB = charcode % 26;

          intArr.push(partA);
          intArr.push(partB);
        }

        return intArr;
      }
function int_array_to_string(intArr){
        let txt = '';
        
        for(let i=0;i<intArr.length;i++){
          first = intArr[i] * 26
          i++
          second = first + intArr[i]
          txt += String.fromCharCode(second)
        }
        return txt;

}
string = 'password'
//console.log(string_to_int_array(string))
//console.log(int_array_to_string(string_to_int_array(string)))

//function string_to_int_array takes a string value, loops through the chars, getting the ASCII character code and
//divides the charcode by 26 and get's its quotient and remainder and adds those two values to an array


function int_array_to_text(int_array){
        let txt = '';

        for(let i=0;i<int_array.length;i++){
          txt += String.fromCharCode(97 + int_array[i]);
        }

        return txt;
      }

function text_to_int_array(str){
        let intArr = [];

        for(let i=0;i<str.length;i++){
          txt = str.charCodeAt(i) - 97;
          //txt += String.fromCharCode(97 + int_array[i]);
          intArr.push(txt)
        }

        return intArr;
      }
my_array = [
  4,  8, 3, 19, 4, 11,
  4, 11, 4, 15, 4,  7,
  4, 10, 3, 22
]
//console.log(int_array_to_text(my_array))
//console.log(int_array_to_string(text_to_int_array(int_array_to_text(string_to_int_array('password')))))
//function int_array_to_text takes an integer array, loops through it's elements and converts the values to characters 
//by adding the elements from int array(+97 for a)


password_hash ='dxeedxebdwemdwesdxdtdweqdxefdxefdxdudueqduerdvdtdvdu'

const hash = int_array_to_text(string_to_int_array(int_array_to_text(string_to_int_array('password'))));
const reve = int_array_to_string(text_to_int_array(int_array_to_string(text_to_int_array(password_hash))));

console.log(hash,'\n',reve)

