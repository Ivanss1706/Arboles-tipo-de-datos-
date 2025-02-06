//import 'dart:io';
import 'dart:math'; //Librería para uso de constantes y funciones matemáticas

//Clase abstracta
abstract class Nodo {

// Clave late: Usado para indicar que las variables serán inicializadas en tiempo de ejecución
  late Nodo izq;
  late Nodo der;
  late int numHijos;

  String get valor;     //Obtener el valor del nodo
  double eval(List x);  //Evaluar la operación
  Nodo clonar();      //Función para copiar arbol
}

class Nodo_interno extends Nodo{
  
  late String _value;  //Atributo privado

//Constructor con nombre
  Nodo_interno.create(String value){
    _value = value;

    switch(_value){
      case "+": numHijos = 2;
        break;
      case "*": numHijos = 2;
        break;
      case "/": numHijos = 2;
        break;
      case "-": numHijos = 2;
        break;
      case "sin": numHijos = 1;
        break;
      case "sqrt": numHijos = 1;
        break;
    }
  }

//Definición y reescritura de la función get valor
  @override
  String get valor{
    late String expresion;
    if(numHijos == 1){
      expresion = _value + '(' + izq.valor + ')';
    }
    if(numHijos == 2){
      expresion = '(' + izq.valor + _value + der.valor + ')';
    }
    return expresion;
  }

//Evaluación del nodo
  @override
  double eval(List x){
    late double eval;

    switch (_value) {
      case "+":
        eval = izq.eval(x) + der.eval(x);
        break;
      case "*":
        eval = izq.eval(x) * der.eval(x);
        break;
      case "/":
        eval = izq.eval(x) / der.eval(x);
        break;
      case "-":
        eval = izq.eval(x) - der.eval(x);
        break;
      case "sin":
        eval = sin(izq.eval(x));
        break;
      case "sqrt":
        eval = sqrt(izq.eval(x));
        break;
      default:
        eval = 0.0;
    }
    return eval;
  }

//Clonación de nodo interno
  @override
  Nodo_interno clonar(){
    Nodo_interno clon_interno = Nodo_interno.create(this._value);
    clon_interno.numHijos = this.numHijos;

    if(numHijos == 1){
      clon_interno.izq = this.izq.clonar();
    }
    if(numHijos == 2){
      clon_interno.izq = this.izq.clonar();
      clon_interno.der = this.der.clonar();
    }
    return clon_interno;
  }
}

//Nodo de tipo constante
class Nodo_hoja_cst extends Nodo{

  late double _value;

//Constructor con nombre
  Nodo_hoja_cst.create(double value){
    _value = value;
    numHijos = 0;
  }

//Reescritura de la función get valor
  @override 
  //Conversión de double a String
  String get valor => _value.toString();
 
//Evaluación de la operación
  @override
  double eval(List x) => _value;
  
//Clonación de nodo constante
  @override
  Nodo_hoja_cst clonar() => Nodo_hoja_cst.create(this._value);
  
}

//Nodo de tipo variable
class Nodo_hoja_var extends Nodo{

  late int _value;

//Constructor con nombre
  Nodo_hoja_var.create(int value){
    _value = value;
    numHijos = 0;
  }

//Reescritura de la función get valor
  @override 
  //Conversión de int a string y concatenación
  String get valor => 'x' + _value.toString();

//Evaluación de la operación
  @override
  double eval(List x) => x[_value];

//Clonación de nodo variable
  @override
  Nodo_hoja_var clonar() => Nodo_hoja_var.create(this._value);

}

//Factory method
abstract class Nodo_creador{

  late int profundidad;
  late int num_variables; 

  Nodo_creador.create(int t, int nv);
  Nodo NodeFactory(int prof_actual); 
}

class fullDepthNodeCreator extends Nodo_creador{

  //Uso del constructor de clase padre abstracta
  fullDepthNodeCreator.create(int p, int nv) : super.create(p, nv){
    profundidad = p;
    num_variables = nv;
  }

  Nodo NodeFactory(int prof_actual) {
    late int moneda;
    var aux = new Random();
    late Nodo NodeFactory;

    if(prof_actual == profundidad){ //Creación de nodo hoja
      if(aux.nextDouble() > 0.5){ //Probabilidad 50/50
        double res = aux.nextDouble();
        String cadRes = res.toStringAsFixed(3); //Número de dígitos después del punto
        res = double.parse(cadRes); //Conversión String a número

        //Creación de Nodo constante con el valor random obtenido
        NodeFactory = Nodo_hoja_cst.create(res);  
      }
      else{ 
        //Creación de Nodo variable con valor xn de acuerdo al resultado del random del número de variables
        NodeFactory = Nodo_hoja_var.create(aux.nextInt(num_variables));
      }
    }
    else{
      moneda = aux.nextInt(6);  //Sorteo 1 - 6

      switch(moneda){
        case 0: NodeFactory = Nodo_interno.create("+");
            break;
        case 1: NodeFactory = Nodo_interno.create("*");
            break;
        case 2: NodeFactory = Nodo_interno.create("/");
            break;
        case 3: NodeFactory = Nodo_interno.create("-");
            break;
        case 4: NodeFactory = Nodo_interno.create("sin");
          break;
        case 5: NodeFactory = Nodo_interno.create("sqrt");
          break;
      }
    }
    return NodeFactory;
  }
}


class randomDepthNodeCreator extends Nodo_creador{

  //Uso del constructor de clase padre abstracta
  randomDepthNodeCreator.create(int p, int nv) : super.create(p, nv){
    profundidad = p;
    num_variables = nv;
  }

  Nodo NodeFactory(int prof_actual) {
    late int moneda;
    var aux = new Random();
    late Nodo NodeFactory;

      if(prof_actual == profundidad || (aux.nextDouble() > 0.5 && prof_actual != 0 )){ //Creación de nodo hoja
          if(aux.nextDouble() > 0.5){ //Probabilidad 50/50
            double res = aux.nextDouble();
            String cadRes = res.toStringAsFixed(3); //Número de dígitos después del punto
            res = double.parse(cadRes); //Conversión String a número

            //Creación de Nodo constante con el valor random obtenido
            NodeFactory = Nodo_hoja_cst.create(res);  
            //print(prof_actual);
          }
          else{ 
            //Creación de Nodo variable con valor xn de acuerdo al resultado del random del número de variables
            NodeFactory = Nodo_hoja_var.create(aux.nextInt(num_variables));
            //print(prof_actual);
          }
      }
      else{
        moneda = aux.nextInt(6);  //Sorteo 1 - 6

          switch(moneda){
            case 0: NodeFactory = Nodo_interno.create("+");
                break;
            case 1: NodeFactory = Nodo_interno.create("*");
                break;
            case 2: NodeFactory = Nodo_interno.create("/");
                break;
            case 3: NodeFactory = Nodo_interno.create("-");
                break;
            case 4: NodeFactory = Nodo_interno.create("sin");
              break;
            case 5: NodeFactory = Nodo_interno.create("sqrt");
              break;
          }
        //print(prof_actual);
      }
      return NodeFactory;
  }
}

class Arbol{

  late int profundidad;
  int contador_nodo = 0;
  late Nodo_creador nodocreador;
  late int num_variables;

//Creación de una lista de nodos vacía no nula
  List<Nodo> nodo = [];

//Constructor con nombre
  Arbol.create(int num_tam, int variables){
    profundidad = num_tam;
    
    //Cálculo del número máximo de nodos
    int aux = (pow(2, profundidad + 1) - 1).toInt();
    //Llenado de lista de manera temporal
    nodo = List.filled(aux, Nodo_interno.create("x"));

    num_variables = variables;
  }

//Reescritura de la función get valor
  String get valor => nodo[0].valor.toString(); //Conversión de todos los datos a String

//Función para insertar nodos
  void insert_Nodo(Nodo n, int pos){

    this.nodo[pos] = n;
    this.contador_nodo = this.contador_nodo + 1;

    if(n.numHijos == 1){
      insert_Nodo(n.izq, this.contador_nodo);
    }

    if(n.numHijos == 2){
      insert_Nodo(n.izq, this.contador_nodo);
      insert_Nodo(n.der, this.contador_nodo);
    }
  }

//Clonar arbol
  Arbol clonar(){
    Nodo nueva_raiz;
    Arbol clon;

      clon = Arbol.create(this.profundidad, this.num_variables);
      nueva_raiz = this.nodo[0].clonar();
      //Inserción de la copia en el nuevo árbol(clon)
      clon.insert_Nodo(nueva_raiz, 0);
    return clon;
  }

//Crear nodos
  void crear_nodos(Nodo aux, int pos_actual){
    if(aux.numHijos == 1){
      aux.izq = nodocreador.NodeFactory(pos_actual);
      crear_nodos(aux.izq, pos_actual + 1);
    }
    if(aux.numHijos == 2){
      aux.izq = nodocreador.NodeFactory(pos_actual);
      crear_nodos(aux.izq, pos_actual + 1);

      aux.der = nodocreador.NodeFactory(pos_actual);
      crear_nodos(aux.der, pos_actual + 1);
    }
  }

//Árbol random
  void arbol_random(){
    Nodo raiz;

    nodocreador = fullDepthNodeCreator.create(profundidad, num_variables);
    raiz = nodocreador.NodeFactory(0);

    crear_nodos(raiz, 1);
    this.insert_Nodo(raiz, 0);
  }

  void arbol_randomDepth(){
    Nodo raiz;

    var aux2 = new Random();
    profundidad = aux2.nextInt(profundidad) + 1;

    nodocreador = randomDepthNodeCreator.create(profundidad, num_variables);
    raiz = nodocreador.NodeFactory(0);

    //print("\nProfundidad random: "  + profundidad.toString());
    crear_nodos(raiz, 1);
    this.insert_Nodo(raiz, 0);
  }

//Evaluación de la operación
  double eval(List x) => nodo[0].eval(x);
}
void main() {

//Declaración de objetos
  Arbol a1 = Arbol.create(4, 2);
  Arbol a2 = Arbol.create(4, 2);

  a1.arbol_random();

  print("Árbol: " + '\n' + a1.valor);
  //print("\nProfundidad árbol 1: " + a1.profundidad.toString());

  a2.arbol_randomDepth();
  print("Árbol 2 : " + '\n' + a2.valor);
}
