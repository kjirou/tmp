var concat:Function = function(a:string, b:string):string{
  return a + b;
};

var r1:string = concat('aaa', 'bbb');
console.log(r1);

// なんでこれエラーにならないんだ？
var r2:string = concat(2, 'bbb');
console.log(r2);
