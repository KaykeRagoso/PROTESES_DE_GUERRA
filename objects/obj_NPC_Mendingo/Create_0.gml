// Chama o Create do pai primeiro
event_inherited();

// Dados do NPC
npc_nome = "Soldado";

// Diálogos
npc_linhas_inicio = [
    "Soldado: Esses monstros estão tomando a cidade!",
    "Soldado: Você consegue eliminá-los?",
    "Soldado: Mate 5 inimigos e volte aqui."
];

npc_linhas_missao = [
    "Soldado: Ainda não terminou...",
    "Soldado: Continue lutando, precisamos de você!"
];

npc_linhas_fim = [
    "Soldado: Incrível! Você conseguiu!",
    "Soldado: Aqui está sua recompensa, herói."
];

missao_id = obj_Missao;

// Liga a missão a este NPC (coloque obj_missao na room e referencie aqui)
// missao_id = obj_missao; // descomente e ajuste pro nome da sua instância
