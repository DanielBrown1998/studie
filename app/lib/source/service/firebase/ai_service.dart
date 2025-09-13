import 'package:firebase_ai/firebase_ai.dart';

class AIService {
  // Define o schema para uma única tarefa.
  static final _taskSchema = Schema.object(
    properties: {
      'horaInicial': Schema.integer(
        description: "A hora de início da tarefa (formato 24h, ex: 8, 14).",
      ),
      'discipline': Schema.string(
        description: "A matéria a ser estudada, com no máximo 18 caracteres.",
      ),
      'description': Schema.string(
        description:
            "Uma breve descrição da tarefa, com no máximo 20 caracteres.",
      ),
    },
    propertyOrdering: ['horaInicial', 'discipline', 'description'],
  );

  // Define o schema para o plano de um dia, que contém o nome do dia e uma lista de tarefas.
  static final _dayPlanSchema = Schema.object(
    properties: {
      'dia': Schema.string(
        description: "O nome do dia da semana (ex: 'segunda-feira').",
      ),
      'tarefas': Schema.array(
        items: _taskSchema,
        description: "Lista de tarefas para este dia.",
      ),
    },
    propertyOrdering: ['dia', 'tarefas'],
  );

  // Define o schema principal que espera um plano semanal, que é uma lista de planos diários.
  static final _jsonSchema = Schema.object(
    properties: {
      'plano_semanal': Schema.array(
        items: _dayPlanSchema,
        description:
            "Uma lista contendo o plano de estudos para cada dia da semana.",
      ),
    },
  );

  late final _model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.5-flash',
    generationConfig: GenerationConfig(
      responseSchema: _jsonSchema,
      responseMimeType: 'application/json', // Força a saída em JSON
    ),
  );

  Future<String?> generateStudyPlan() async {
    try {
      final prompt = [
        Content.text(
          'Crie um plano de estudos semanal focado no concurso do ITA. O plano deve cobrir de segunda a sexta-feira. Os horários de estudo são: das 8h às 12h, das 13h às 15h e das 17h às 22h. Por favor, gere a resposta estritamente no formato JSON definido no schema. Certifique-se de que os valores de "discipline" e "description" respeitem os limites de caracteres definidos no schema.',
        ),
      ];

      final response = await _model.generateContent(prompt);
      return response.text;
    } catch (e) {
      // Idealmente, usar um serviço de logging como Crashlytics aqui.
      print('Erro ao gerar plano de estudos: $e');
      return null;
    }
  }
}
