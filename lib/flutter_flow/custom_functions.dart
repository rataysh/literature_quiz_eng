import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

bool? checkValidateName(String? userName) {
  return userName!.length >= 2;
}

bool? strIsEmpty(String? str) {
  return str?.isEmpty;
}

bool? checkPhotoUrl(String? image) {
  return image?.isEmpty;
}

List<dynamic> getAllAuthors() {
  const List<Map> authors = [
    {
      'myId': '1WilliamShakespeare',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a2/Shakespeare.jpg/330px-Shakespeare.jpg',
      'fullName': 'William Shakespeare'
    },
    {
      'myId': '2CharlesDickens',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/Dickens_Gurney_head.jpg/330px-Dickens_Gurney_head.jpg',
      'fullName': 'Charles Dickens'
    },
    {
      'myId': '3JaneAusten',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/%D0%94%D0%B6%D0%B5%D0%B9%D0%BD_%D0%9E%D1%81%D1%82%D0%B8%D0%BD.jpg/330px-%D0%94%D0%B6%D0%B5%D0%B9%D0%BD_%D0%9E%D1%81%D1%82%D0%B8%D0%BD.jpg',
      'fullName': 'Jane Austen'
    },
    {
      'myId': '4MarkTwain',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/Mark_Twain_by_AF_Bradley.jpg/330px-Mark_Twain_by_AF_Bradley.jpg',
      'fullName': 'Mark Twain'
    },
    {
      'myId': '5ErnestHemingway',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/28/ErnestHemingway.jpg/411px-ErnestHemingway.jpg',
      'fullName': 'Ernest Hemingway'
    },
    {
      'myId': '6FyodorDostoevsky',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Vasily_Perov_-_%D0%9F%D0%BE%D1%80%D1%82%D1%80%D0%B5%D1%82_%D0%A4.%D0%9C.%D0%94%D0%BE%D1%81%D1%82%D0%BE%D0%B5%D0%B2%D1%81%D0%BA%D0%BE%D0%B3%D0%BE_-_Google_Art_Project.jpg/360px-Vasily_Perov_-_%D0%9F%D0%BE%D1%80%D1%82%D1%80%D0%B5%D1%82_%D0%A4.%D0%9C.%D0%94%D0%BE%D1%81%D1%82%D0%BE%D0%B5%D0%B2%D1%81%D0%BA%D0%BE%D0%B3%D0%BE_-_Google_Art_Project.jpg',
      'fullName': 'Fyodor Dostoevsky'
    },
    {
      'myId': '7EdgarAllanPoe',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/97/Edgar_Allan_Poe%2C_circa_1849%2C_restored%2C_squared_off.jpg/330px-Edgar_Allan_Poe%2C_circa_1849%2C_restored%2C_squared_off.jpg',
      'fullName': 'Edgar Allan Poe'
    },
    {
      'myId': '8LeoTolstoy',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Leo_Tolstoy%2C_portrait.jpg/411px-Leo_Tolstoy%2C_portrait.jpg',
      'fullName': 'Leo Tolstoy'
    },
    {
      'myId': '9FranzKafka',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Franz_Kafka%2C_1923.jpg/330px-Franz_Kafka%2C_1923.jpg',
      'fullName': 'Franz Kafka'
    },
    {
      'myId': '10JohnSteinbeck',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/John_Steinbeck_1939_%28cropped%29.jpg/330px-John_Steinbeck_1939_%28cropped%29.jpg',
      'fullName': 'John Steinbeck'
    },
    {
      'myId': '11JorgeLuisBorges',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Jorge_Luis_Borges_1951%2C_by_Grete_Stern.jpg/330px-Jorge_Luis_Borges_1951%2C_by_Grete_Stern.jpg',
      'fullName': 'Jorge Luis Borges'
    },
    {
      'myId': '12VirginiaWoolf',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/George_Charles_Beresford_-_Virginia_Woolf_in_1902_-_Restoration.jpg/330px-George_Charles_Beresford_-_Virginia_Woolf_in_1902_-_Restoration.jpg',
      'fullName': 'Virginia Woolf'
    },
    {
      'myId': '13GabrielGarcíaMárquez',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/Gabriel_Garcia_Marquez.jpg/300px-Gabriel_Garcia_Marquez.jpg',
      'fullName': 'Gabriel García Márquez'
    },
    {
      'myId': '14JamesJoyce',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/Revolutionary_Joyce_Better_Contrast.jpg/330px-Revolutionary_Joyce_Better_Contrast.jpg',
      'fullName': 'James Joyce'
    },
    {
      'myId': '15SamuelBeckett',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Samuel_Beckett%2C_Pic%2C_1_%28cropped%29.jpg/330px-Samuel_Beckett%2C_Pic%2C_1_%28cropped%29.jpg',
      'fullName': 'Samuel Beckett'
    },
    {
      'myId': '16WilliamFaulkner',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Carl_Van_Vechten_-_William_Faulkner.jpg/330px-Carl_Van_Vechten_-_William_Faulkner.jpg',
      'fullName': 'William Faulkner'
    },
    {
      'myId': '17SalmanRushdie',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Salman_Rushdie_2014_%28cropped%29.jpg/330px-Salman_Rushdie_2014_%28cropped%29.jpg',
      'fullName': 'Salman Rushdie'
    },
    {
      'myId': '18HarukiMurakami',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/7/71/HarukiMurakami_%28cropped%29.png',
      'fullName': 'Haruki Murakami'
    },
    {
      'myId': '19KazuoIshiguro',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c9/Kazuo_Ishiguro_in_2017_01.jpg/330px-Kazuo_Ishiguro_in_2017_01.jpg',
      'fullName': 'Kazuo Ishiguro'
    },
    {
      'myId': '20ToniMorrison',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Toni_Morrison.jpg/330px-Toni_Morrison.jpg',
      'fullName': 'Toni Morrison'
    },
    {
      'myId': '21AldousHuxley',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Aldous_Huxley_psychical_researcher.png/330px-Aldous_Huxley_psychical_researcher.png',
      'fullName': 'Aldous Huxley'
    },
    {
      'myId': '22GeorgeOrwell',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/George_Orwell_press_photo.jpg/330px-George_Orwell_press_photo.jpg',
      'fullName': 'George Orwell'
    },
    {
      'myId': '23SylviaPlath',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/d/d0/Sylvia_Plath.jpg',
      'fullName': 'Sylvia Plath'
    },
    {
      'myId': '24VladimirNabokov',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/Vladimir_Nabokov_1973.jpg/330px-Vladimir_Nabokov_1973.jpg',
      'fullName': 'Vladimir Nabokov'
    },
    {
      'myId': '25MarcelProust',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/c/cb/Marcel_Proust_vers_1895.jpg',
      'fullName': 'Marcel Proust'
    },
    {
      'myId': '26DanteAlighieri',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6f/Portrait_de_Dante.jpg/395px-Portrait_de_Dante.jpg',
      'fullName': 'Dante Alighieri'
    },
    {
      'myId': '27MigueldeCervantes',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Cervantes_J%C3%A1uregui.jpg/330px-Cervantes_J%C3%A1uregui.jpg',
      'fullName': 'Miguel de Cervantes'
    },
    {
      'myId': '28EmilyDickinson',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/56/Black-white_photograph_of_Emily_Dickinson2.png/330px-Black-white_photograph_of_Emily_Dickinson2.png',
      'fullName': 'Emily Dickinson'
    },
    {
      'myId': '29OscarWilde',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Oscar_Wilde_3g07095u-adjust.jpg/330px-Oscar_Wilde_3g07095u-adjust.jpg',
      'fullName': 'Oscar Wilde'
    },
    {
      'myId': '30RobertLouisStevenson',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Robert_Louis_Stevenson_by_Henry_Walter_Barnett_bw.jpg/330px-Robert_Louis_Stevenson_by_Henry_Walter_Barnett_bw.jpg',
      'fullName': 'Robert Louis Stevenson'
    },
    {
      'myId': '31AlbertCamus',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/08/Albert_Camus%2C_gagnant_de_prix_Nobel%2C_portrait_en_buste%2C_pos%C3%A9_au_bureau%2C_faisant_face_%C3%A0_gauche%2C_cigarette_de_tabagisme.jpg/330px-Albert_Camus%2C_gagnant_de_prix_Nobel%2C_portrait_en_buste%2C_pos%C3%A9_au_bureau%2C_faisant_face_%C3%A0_gauche%2C_cigarette_de_tabagisme.jpg',
      'fullName': 'Albert Camus'
    },
    {
      'myId': '32JohnKeats',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/John_Keats_by_William_Hilton.jpg/330px-John_Keats_by_William_Hilton.jpg',
      'fullName': 'John Keats'
    },
    {
      'myId': '33PercyByssheShelley',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/57/Percy_Bysshe_Shelley_by_Alfred_Clint.jpg/330px-Percy_Bysshe_Shelley_by_Alfred_Clint.jpg',
      'fullName': 'Percy Bysshe Shelley'
    },
    {
      'myId': '34WilliamButlerYeats',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Yeats_Boughton.jpg/330px-Yeats_Boughton.jpg',
      'fullName': 'William Butler Yeats'
    },
    {
      'myId': '35LordByron',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Byron_1813_by_Phillips.jpg/330px-Byron_1813_by_Phillips.jpg',
      'fullName': 'Lord Byron'
    },
    {
      'myId': '36WystanHughAuden',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/aa/AudenVanVechten1939.jpg/330px-AudenVanVechten1939.jpg',
      'fullName': 'Wystan Hugh Auden'
    },
    {
      'myId': '37ThomasStearnsEliot',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/26/Thomas_Stearns_Eliot_by_Lady_Ottoline_Morrell_%281934%29.jpg/330px-Thomas_Stearns_Eliot_by_Lady_Ottoline_Morrell_%281934%29.jpg',
      'fullName': 'Thomas Stearns Eliot'
    },
    {
      'myId': '38EdwardEstlinCummings',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3b/E._E._Cummings_NYWTS.jpg/330px-E._E._Cummings_NYWTS.jpg',
      'fullName': 'Edward Estlin Cummings'
    },
    {
      'myId': '39LangstonHughes',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/LangstonHughes_crop.jpg/330px-LangstonHughes_crop.jpg',
      'fullName': 'Langston Hughes'
    },
    {
      'myId': '40ZoraNealeHurston',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/57/Hurston-Zora-Neale-LOC.jpg/330px-Hurston-Zora-Neale-LOC.jpg',
      'fullName': 'Zora Neale Hurston'
    },
    {
      'myId': '41JamesBaldwin',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/James_Baldwin_37_Allan_Warren_%28cropped%29.jpg/330px-James_Baldwin_37_Allan_Warren_%28cropped%29.jpg',
      'fullName': 'James Baldwin'
    },
    {
      'myId': '42TrumanCapote',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/Truman_Capote_by_Jack_Mitchell.jpg/330px-Truman_Capote_by_Jack_Mitchell.jpg',
      'fullName': 'Truman Capote'
    },
    {
      'myId': '43JackKerouac',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/3/37/Kerouac_by_Palumbo_2_%28cropped%29.png/330px-Kerouac_by_Palumbo_2_%28cropped%29.png',
      'fullName': 'Jack Kerouac'
    },
    {
      'myId': '44AllenGinsberg',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Allen_Ginsberg_1979_-_cropped.jpg/330px-Allen_Ginsberg_1979_-_cropped.jpg',
      'fullName': 'Allen Ginsberg'
    },
    {
      'myId': '45NathanielHawthorne',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Nathaniel_Hawthorne_by_Brady%2C_1860-64.jpg/330px-Nathaniel_Hawthorne_by_Brady%2C_1860-64.jpg',
      'fullName': 'Nathaniel Hawthorne'
    },
    {
      'myId': '46HenryDavidThoreau',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/2a/Benjamin_D._Maxham_-_Henry_David_Thoreau_-_Restored_-_greyscale_-_straightened.jpg/330px-Benjamin_D._Maxham_-_Henry_David_Thoreau_-_Restored_-_greyscale_-_straightened.jpg',
      'fullName': 'Henry David Thoreau'
    },
    {
      'myId': '47WaltWhitman',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/f/fa/Walt_Whitman_-_George_Collins_Cox.jpg/330px-Walt_Whitman_-_George_Collins_Cox.jpg',
      'fullName': 'Walt Whitman'
    },
    {
      'myId': '48RalphWaldoEmerson',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Ralph_Waldo_Emerson_by_Josiah_Johnson_Hawes_1857.jpg/330px-Ralph_Waldo_Emerson_by_Josiah_Johnson_Hawes_1857.jpg',
      'fullName': 'Ralph Waldo Emerson'
    },
    {
      'myId': '49WilliamCarlosWilliams',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/William_Carlos_Williams_passport_photograph_1921_%28cropped%29.jpg/330px-William_Carlos_Williams_passport_photograph_1921_%28cropped%29.jpg',
      'fullName': 'William Carlos Williams'
    },
    {
      'myId': '50FrancisScottKeyFitzgerald',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/87/F._Scott_Fitzgerald_%281929_photo_portrait_by_Nickolas_Muray%29_Cropped.jpg/330px-F._Scott_Fitzgerald_%281929_photo_portrait_by_Nickolas_Muray%29_Cropped.jpg',
      'fullName': 'Francis Scott Key Fitzgerald'
    },
    {
      'myId': '51GertrudeStein',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/2/25/Gertrude_Stein_1935-01-04.jpg/330px-Gertrude_Stein_1935-01-04.jpg',
      'fullName': 'Gertrude Stein'
    },
    {
      'myId': '52EdgarLawrenceDoctorow',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/8/80/E_l_doctorow_2751.JPG/330px-E_l_doctorow_2751.JPG',
      'fullName': 'Edgar Lawrence Doctorow'
    },
    {
      'myId': '53AliceWalker',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/5/59/Alice_Walker.jpg/330px-Alice_Walker.jpg',
      'fullName': 'Alice Walker'
    },
    {
      'myId': '54DavidFosterWallace',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/David_Foster_Wallace.jpg/330px-David_Foster_Wallace.jpg',
      'fullName': 'David Foster Wallace'
    },
    {
      'myId': '55MargaretAtwood',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Margaret_Atwood_2015.jpg/330px-Margaret_Atwood_2015.jpg',
      'fullName': 'Margaret Atwood'
    },
    {
      'myId': '56StephenKing',
      'secondName': "",
      'firstName': "",
      'patronymicName': "",
      'initials': "",
      'image':
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Stephen_King%2C_Comicon.jpg/330px-Stephen_King%2C_Comicon.jpg',
      'fullName': 'Stephen King'
    }
  ];
  return authors;
}

List<dynamic> getAllBooks() {
  const List<Map> allBooks = [
    {'title': 'Romeo and Juliet', 'authorId': '1WilliamShakespeare'},
    {'title': 'Hamlet', 'authorId': '1WilliamShakespeare'},
    {'title': 'Macbeth', 'authorId': '1WilliamShakespeare'},
    {'title': 'Othello', 'authorId': '1WilliamShakespeare'},
    {'title': 'Julius Caesar', 'authorId': '1WilliamShakespeare'},
    {'title': 'Oliver Twist', 'authorId': '2CharlesDickens'},
    {'title': 'A Tale of Two Cities', 'authorId': '2CharlesDickens'},
    {'title': 'Great Expectations', 'authorId': '2CharlesDickens'},
    {'title': 'David Copperfield', 'authorId': '2CharlesDickens'},
    {'title': 'Pride and Prejudice', 'authorId': '3JaneAusten'},
    {'title': 'Sense and Sensibility', 'authorId': '3JaneAusten'},
    {'title': 'Emma', 'authorId': '3JaneAusten'},
    {'title': 'Mansfield Park', 'authorId': '3JaneAusten'},
    {'title': 'The Adventures of Tom Sawyer', 'authorId': '4MarkTwain'},
    {'title': 'The Adventures of Huckleberry Finn', 'authorId': '4MarkTwain'},
    {
      'title': "A Connecticut Yankee in King Arthur's Court",
      'authorId': '4MarkTwain'
    },
    {'title': 'The Prince and the Pauper', 'authorId': '4MarkTwain'},
    {'title': 'The Old Man and the Sea', 'authorId': '5ErnestHemingway'},
    {'title': 'For Whom the Bell Tolls', 'authorId': '5ErnestHemingway'},
    {'title': 'A Farewell to Arms', 'authorId': '5ErnestHemingway'},
    {'title': 'The Sun Also Rises', 'authorId': '5ErnestHemingway'},
    {'title': 'Crime and Punishment', 'authorId': '6FyodorDostoevsky'},
    {'title': 'The Brothers Karamazov', 'authorId': '6FyodorDostoevsky'},
    {'title': 'The Idiot', 'authorId': '6FyodorDostoevsky'},
    {'title': 'Notes from Underground', 'authorId': '6FyodorDostoevsky'},
    {'title': 'The Raven', 'authorId': '7EdgarAllanPoe'},
    {'title': 'The Tell-Tale Heart', 'authorId': '7EdgarAllanPoe'},
    {'title': 'The Gold-Bug', 'authorId': '7EdgarAllanPoe'},
    {'title': 'The Black Cat', 'authorId': '7EdgarAllanPoe'},
    {'title': 'The Cask of Amontillado', 'authorId': '7EdgarAllanPoe'},
    {'title': 'War and Peace', 'authorId': '8LeoTolstoy'},
    {'title': 'Anna Karenina', 'authorId': '8LeoTolstoy'},
    {'title': 'The Death of Ivan Ilyich', 'authorId': '8LeoTolstoy'},
    {'title': 'Hadji Murad', 'authorId': '8LeoTolstoy'},
    {'title': 'The Metamorphosis', 'authorId': '9FranzKafka'},
    {'title': 'The Trial', 'authorId': '9FranzKafka'},
    {'title': 'The Castle', 'authorId': '9FranzKafka'},
    {'title': 'Amerika', 'authorId': '9FranzKafka'},
    {'title': 'Of Mice and Men', 'authorId': '10JohnSteinbeck'},
    {'title': 'The Grapes of Wrath', 'authorId': '10JohnSteinbeck'},
    {'title': 'East of Eden', 'authorId': '10JohnSteinbeck'},
    {'title': 'Cannery Row', 'authorId': '10JohnSteinbeck'},
    {'title': 'Ficciones', 'authorId': '11JorgeLuisBorges'},
    {'title': 'The Book of Sand', 'authorId': '11JorgeLuisBorges'},
    {'title': 'Labyrinths', 'authorId': '11JorgeLuisBorges'},
    {'title': 'A Universal History of Infamy', 'authorId': '11JorgeLuisBorges'},
    {'title': 'Mrs. Dalloway', 'authorId': '12VirginiaWoolf'},
    {'title': 'To the Lighthouse', 'authorId': '12VirginiaWoolf'},
    {'title': 'Orlando', 'authorId': '12VirginiaWoolf'},
    {'title': "A Room of One's Own", 'authorId': '12VirginiaWoolf'},
    {
      'title': 'One Hundred Years of Solitude',
      'authorId': '13GabrielGarcíaMárquez'
    },
    {
      'title': 'Love in the Time of Cholera',
      'authorId': '13GabrielGarcíaMárquez'
    },
    {
      'title': 'The Autumn of the Patriarch',
      'authorId': '13GabrielGarcíaMárquez'
    },
    {
      'title': 'Chronicle of a Death Foretold',
      'authorId': '13GabrielGarcíaMárquez'
    },
    {'title': 'Ulysses', 'authorId': '14JamesJoyce'},
    {'title': 'Dubliners', 'authorId': '14JamesJoyce'},
    {
      'title': 'A Portrait of the Artist as a Young Man',
      'authorId': '14JamesJoyce'
    },
    {'title': 'Finnegans Wake', 'authorId': '14JamesJoyce'},
    {'title': 'Waiting for Godot', 'authorId': '15SamuelBeckett'},
    {'title': 'Endgame', 'authorId': '15SamuelBeckett'},
    {'title': "Krapp's Last Tape", 'authorId': '15SamuelBeckett'},
    {'title': 'Happy Days', 'authorId': '15SamuelBeckett'},
    {'title': 'The Sound and the Fury', 'authorId': '16WilliamFaulkner'},
    {'title': 'As I Lay Dying', 'authorId': '16WilliamFaulkner'},
    {'title': 'Light in August', 'authorId': '16WilliamFaulkner'},
    {'title': 'Absalom', 'authorId': '16WilliamFaulkner'},
    {'title': "Midnight's Children", 'authorId': '17SalmanRushdie'},
    {'title': 'Shame', 'authorId': '17SalmanRushdie'},
    {'title': "The Moor's Last Sigh", 'authorId': '17SalmanRushdie'},
    {'title': 'The Satanic Verses', 'authorId': '17SalmanRushdie'},
    {'title': 'Norwegian Wood', 'authorId': '18HarukiMurakami'},
    {'title': 'Kafka on the Shore', 'authorId': '18HarukiMurakami'},
    {'title': '1Q84', 'authorId': '18HarukiMurakami'},
    {'title': 'After Dark', 'authorId': '18HarukiMurakami'},
    {'title': 'The Remains of the Day', 'authorId': '19KazuoIshiguro'},
    {'title': 'Never Let Me Go', 'authorId': '19KazuoIshiguro'},
    {'title': 'An Artist of the Floating World', 'authorId': '19KazuoIshiguro'},
    {'title': 'The Buried Giant', 'authorId': '19KazuoIshiguro'},
    {'title': 'Beloved', 'authorId': '20ToniMorrison'},
    {'title': 'Song of Solomon', 'authorId': '20ToniMorrison'},
    {'title': 'The Bluest Eye', 'authorId': '20ToniMorrison'},
    {'title': 'Sula', 'authorId': '20ToniMorrison'},
    {'title': 'Brave New World', 'authorId': '21AldousHuxley'},
    {'title': 'Island', 'authorId': '21AldousHuxley'},
    {'title': 'The Doors of Perception', 'authorId': '21AldousHuxley'},
    {'title': 'Time Must Have a Stop', 'authorId': '21AldousHuxley'},
    {'title': 1984, 'authorId': '22GeorgeOrwell'},
    {'title': 'Animal Farm', 'authorId': '22GeorgeOrwell'},
    {'title': 'Burmese Days', 'authorId': '22GeorgeOrwell'},
    {'title': 'Coming Up for Air', 'authorId': '22GeorgeOrwell'},
    {'title': 'The Bell Jar', 'authorId': '23SylviaPlath'},
    {'title': 'Ariel', 'authorId': '23SylviaPlath'},
    {'title': 'Crossing the Water', 'authorId': '23SylviaPlath'},
    {
      'title': 'Johnny Panic and the Bible of Dreams',
      'authorId': '23SylviaPlath'
    },
    {'title': 'Lolita', 'authorId': '24VladimirNabokov'},
    {'title': 'Pale Fire', 'authorId': '24VladimirNabokov'},
    {'title': 'Bend Sinister', 'authorId': '24VladimirNabokov'},
    {'title': 'Speak', 'authorId': '24VladimirNabokov'},
    {'title': 'Memory', 'authorId': '24VladimirNabokov'},
    {'title': 'In Search of Lost Time', 'authorId': '25MarcelProust'},
    {'title': "Swann's Way", 'authorId': '25MarcelProust'},
    {'title': 'Within a Budding Grove', 'authorId': '25MarcelProust'},
    {'title': 'The Guermantes Way', 'authorId': '25MarcelProust'},
    {'title': 'The Divine Comedy', 'authorId': '26DanteAlighieri'},
    {'title': 'Inferno', 'authorId': '26DanteAlighieri'},
    {'title': 'Purgatorio', 'authorId': '26DanteAlighieri'},
    {'title': 'Paradiso', 'authorId': '26DanteAlighieri'},
    {'title': 'Don Quixote', 'authorId': '27MigueldeCervantes'},
    {'title': 'Exemplary Novels', 'authorId': '27MigueldeCervantes'},
    {'title': 'Persiles and Sigismunda', 'authorId': '27MigueldeCervantes'},
    {'title': 'The Galatea', 'authorId': '27MigueldeCervantes'},
    {'title': 'Poems', 'authorId': '28EmilyDickinson'},
    {'title': 'The Gorgeous Nothings', 'authorId': '28EmilyDickinson'},
    {'title': 'Selected Poems and Letters', 'authorId': '28EmilyDickinson'},
    {'title': 'The Belle of Amherst', 'authorId': '28EmilyDickinson'},
    {'title': 'The Picture of Dorian Gray', 'authorId': '29OscarWilde'},
    {'title': 'The Importance of Being Earnest', 'authorId': '29OscarWilde'},
    {'title': "Lady Windermere's Fan", 'authorId': '29OscarWilde'},
    {'title': 'De Profundis', 'authorId': '29OscarWilde'},
    {'title': 'Treasure Island', 'authorId': '30RobertLouisStevenson'},
    {'title': 'Kidnapped', 'authorId': '30RobertLouisStevenson'},
    {
      'title': 'Strange Case of Dr. Jekyll and Mr. Hyde',
      'authorId': '30RobertLouisStevenson'
    },
    {
      'title': "A Child's Garden of Verses",
      'authorId': '30RobertLouisStevenson'
    },
    {'title': 'The Stranger', 'authorId': '31AlbertCamus'},
    {'title': 'The Plague', 'authorId': '31AlbertCamus'},
    {'title': 'The Myth of Sisyphus', 'authorId': '31AlbertCamus'},
    {'title': 'The Rebel', 'authorId': '31AlbertCamus'},
    {'title': 'Ode to a Nightingale', 'authorId': '32JohnKeats'},
    {'title': 'On a Grecian Urn', 'authorId': '32JohnKeats'},
    {'title': 'To Autumn', 'authorId': '32JohnKeats'},
    {'title': 'La Belle Dame sans Merci', 'authorId': '32JohnKeats'},
    {'title': 'Prometheus Unbound', 'authorId': '33PercyByssheShelley'},
    {'title': 'Adonais', 'authorId': '33PercyByssheShelley'},
    {'title': 'To a Skylark', 'authorId': '33PercyByssheShelley'},
    {'title': 'The Masque of Anarchy', 'authorId': '33PercyByssheShelley'},
    {'title': 'The Tower', 'authorId': '34WilliamButlerYeats'},
    {
      'title': 'The Winding Stair and Other Poems',
      'authorId': '34WilliamButlerYeats'
    },
    {
      'title': 'Responsibilities and Other Poems',
      'authorId': '34WilliamButlerYeats'
    },
    {
      'title': 'The Collected Poems of W.B. Yeats',
      'authorId': '34WilliamButlerYeats'
    },
    {'title': 'Don Juan', 'authorId': '35LordByron'},
    {'title': "Childe Harold's Pilgrimage", 'authorId': '35LordByron'},
    {'title': 'The Prisoner of Chillon', 'authorId': '35LordByron'},
    {'title': 'Manfred', 'authorId': '35LordByron'},
    {'title': 'The Age of Anxiety', 'authorId': '36WystanHughAuden'},
    {'title': 'For the Time Being', 'authorId': '36WystanHughAuden'},
    {'title': 'New Year Letter', 'authorId': '36WystanHughAuden'},
    {
      'title': 'The Collected Poems of W. H. Auden',
      'authorId': '36WystanHughAuden'
    },
    {'title': 'The Waste Land', 'authorId': '37ThomasStearnsEliot'},
    {'title': 'Four Quartets', 'authorId': '37ThomasStearnsEliot'},
    {
      'title': 'The Love Song of J. Alfred Prufrock',
      'authorId': '37ThomasStearnsEliot'
    },
    {'title': 'Ash Wednesday', 'authorId': '37ThomasStearnsEliot'},
    {'title': '95 Poems', 'authorId': '38EdwardEstlinCummings'},
    {'title': 'Tulips and Chimneys', 'authorId': '38EdwardEstlinCummings'},
    {'title': 'The Weary Blues', 'authorId': '39LangstonHughes'},
    {'title': 'Not Without Laughter', 'authorId': '39LangstonHughes'},
    {'title': 'Fine Clothes to the Jew', 'authorId': '39LangstonHughes'},
    {'title': 'The Panther and the Lash', 'authorId': '39LangstonHughes'},
    {'title': 'Their Eyes Were Watching God', 'authorId': '40ZoraNealeHurston'},
    {'title': 'Mules and Men', 'authorId': '40ZoraNealeHurston'},
    {'title': 'Dust Tracks on a Road', 'authorId': '40ZoraNealeHurston'},
    {'title': 'Seraph on the Suwanee.', 'authorId': '40ZoraNealeHurston'},
    {'title': 'Go Tell It on the Mountain', 'authorId': '41JamesBaldwin'},
    {'title': "Giovanni's Room", 'authorId': '41JamesBaldwin'},
    {'title': 'Nobody Knows My Name', 'authorId': '41JamesBaldwin'},
    {'title': 'Another Country', 'authorId': '41JamesBaldwin'},
    {'title': 'In Cold Blood', 'authorId': '42TrumanCapote'},
    {'title': "Breakfast at Tiffany's", 'authorId': '42TrumanCapote'},
    {'title': 'A Tree of Night', 'authorId': '42TrumanCapote'},
    {'title': 'Music for Chameleons', 'authorId': '42TrumanCapote'},
    {'title': 'On the Road', 'authorId': '43JackKerouac'},
    {'title': 'The Dharma Bums', 'authorId': '43JackKerouac'},
    {'title': 'Big Sur', 'authorId': '43JackKerouac'},
    {'title': 'Desolation Angels', 'authorId': '43JackKerouac'},
    {'title': 'Howl', 'authorId': '44AllenGinsberg'},
    {'title': 'Kaddish and Other Poems', 'authorId': '44AllenGinsberg'},
    {'title': 'White Shroud', 'authorId': '44AllenGinsberg'},
    {'title': 'The Scarlet Letter', 'authorId': '45NathanielHawthorne'},
    {
      'title': 'The House of the Seven Gables',
      'authorId': '45NathanielHawthorne'
    },
    {'title': 'Twice-Told Tales', 'authorId': '45NathanielHawthorne'},
    {'title': 'Mosses from an Old Manse', 'authorId': '45NathanielHawthorne'},
    {'title': 'Walden', 'authorId': '46HenryDavidThoreau'},
    {'title': 'Civil Disobedience', 'authorId': '46HenryDavidThoreau'},
    {'title': 'The Maine Woods', 'authorId': '46HenryDavidThoreau'},
    {
      'title': 'A Week on the Concord and Merrimack Rivers',
      'authorId': '46HenryDavidThoreau'
    },
    {'title': 'Leaves of Grass', 'authorId': '47WaltWhitman'},
    {
      'title': "When I Heard the Learn'd Astronomer",
      'authorId': '47WaltWhitman'
    },
    {'title': 'O Captain! My Captain!', 'authorId': '47WaltWhitman'},
    {
      'title': 'Out of the Cradle Endlessly Rocking',
      'authorId': '47WaltWhitman'
    },
    {'title': 'Nature', 'authorId': '48RalphWaldoEmerson'},
    {'title': 'Self-Reliance', 'authorId': '48RalphWaldoEmerson'},
    {'title': 'The American Scholar', 'authorId': '48RalphWaldoEmerson'},
    {'title': 'Essays', 'authorId': '48RalphWaldoEmerson'},
    {'title': 'Paterson', 'authorId': '49WilliamCarlosWilliams'},
    {
      'title': 'The Collected Poems of William Carlos Williams',
      'authorId': '49WilliamCarlosWilliams'
    },
    {'title': 'A Recognizable Image', 'authorId': '49WilliamCarlosWilliams'},
    {'title': 'The Red Wheelbarrow', 'authorId': '49WilliamCarlosWilliams'},
    {'title': 'The Great Gatsby', 'authorId': '50FrancisScottKeyFitzgerald'},
    {'title': 'Tender Is the Night', 'authorId': '50FrancisScottKeyFitzgerald'},
    {
      'title': 'This Side of Paradise',
      'authorId': '50FrancisScottKeyFitzgerald'
    },
    {
      'title': 'The Beautiful and Damned',
      'authorId': '50FrancisScottKeyFitzgerald'
    },
    {'title': 'Three Lives', 'authorId': '51GertrudeStein'},
    {'title': 'Tender Buttons', 'authorId': '51GertrudeStein'},
    {'title': 'The Making of Americans', 'authorId': '51GertrudeStein'},
    {'title': 'Narration', 'authorId': '51GertrudeStein'},
    {'title': 'Ragtime', 'authorId': '52EdgarLawrenceDoctorow'},
    {'title': 'The Book of Daniel', 'authorId': '52EdgarLawrenceDoctorow'},
    {'title': "World's Fair", 'authorId': '52EdgarLawrenceDoctorow'},
    {'title': 'Billy Bathgate', 'authorId': '52EdgarLawrenceDoctorow'},
    {'title': 'The Color Purple', 'authorId': '53AliceWalker'},
    {'title': 'Meridian', 'authorId': '53AliceWalker'},
    {'title': "In Search of Our Mothers' Gardens", 'authorId': '53AliceWalker'},
    {'title': 'The Temple of My Familiar', 'authorId': '53AliceWalker'},
    {'title': 'Infinite Jest', 'authorId': '54DavidFosterWallace'},
    {'title': 'The Broom of the System', 'authorId': '54DavidFosterWallace'},
    {
      'title': "A Supposedly Fun Thing I'll Never Do Again",
      'authorId': '54DavidFosterWallace'
    },
    {'title': 'Consider the Lobster', 'authorId': '54DavidFosterWallace'},
    {'title': "The Handmaid's Tale", 'authorId': '55MargaretAtwood'},
    {'title': "Cat's Eye", 'authorId': '55MargaretAtwood'},
    {'title': 'Alias Grace', 'authorId': '55MargaretAtwood'},
    {'title': 'The Blind Assassin', 'authorId': '55MargaretAtwood'},
    {'title': 'The Shining', 'authorId': '56StephenKing'},
    {'title': 'IT', 'authorId': '56StephenKing'},
    {'title': "Salem's Lot", 'authorId': '56StephenKing'},
    {'title': 'Misery', 'authorId': '56StephenKing'},
    {'title': '11/22/63', 'authorId': '56StephenKing'},
    {'title': 'The Dark Tower', 'authorId': '56StephenKing'},
  ];
  return allBooks;
}

int getRandomNumberIntoList(List<dynamic> arr) {
  final int resultNumber = math.Random().nextInt(arr.length);
  return resultNumber;
}

List<dynamic> getNewGameArr(
  List<dynamic> arr,
  String? difficult,
) {
  // List containing only unique values
  late List<int> noRepitNumbers = [];
  // Result JSON with difficult lenth
  final List<Map> tempJson = [];
  // Counter dependence from difficult
  final int counter = difficult == "0"
      ? 10
      : difficult == "1"
          ? 15
          : 20;
  // create unique values
  for (var i = 0; i < counter; i++) {
    late int curentNum;
    do {
      curentNum = getRandomNumberIntoList(arr);
    } while (noRepitNumbers.contains(curentNum));
    noRepitNumbers.add(curentNum);
  }
  // create unique JSON items
  noRepitNumbers.forEach((item) {
    tempJson.add(arr[item]);
  });

  return tempJson;
}

List<int> getFourRandomNumberFromZeroToThree() {
  final List<int> forRandomNumber = [];
  // Get 4 random number for ansvers variant
  for (var i = 0; i < 4; i++) {
    late int tempNumber;
    do {
      tempNumber = getRandomNumberIntoList([0, 1, 2, 3]);
    } while (forRandomNumber.contains(tempNumber));
    forRandomNumber.add(tempNumber);
  }
  return forRandomNumber;
}

List<dynamic> namesGetFourItems(
  List<dynamic> currentArr,
  int currentQuestion,
  List<dynamic> allArr,
) {
// new vesrion
  final random = new math.Random();
  // final filteredArr = allArr
  //     .where(
  //         (element) => element["myId"] != currentArr[currentQuestion]["myId"])
  //     .toList();
  final List<dynamic> result = [currentArr[currentQuestion]];
  // final resultNames = [
  //   currentArr[currentQuestion]["firstName"] +
  //       currentArr[currentQuestion]["patronymicName"]
  // ];

  while (result.length < 4) {
    final randomIndex = random.nextInt(allArr.length);
    final randomElement = allArr[randomIndex];
    // final randomElementName = allArr[randomIndex]["firstName"] +
    //     allArr[randomIndex]["patronymicName"];
    if (!result.contains(randomElement)) {
      result.add(randomElement);
      // resultNames.add(randomElementName);
    }
  }
  // mixing arr consisting from four item
  final List<dynamic> resultReturn = [];
  final List<int> fourRandom = getFourRandomNumberFromZeroToThree();
  fourRandom.forEach((item) {
    resultReturn.add(result[item]);
  });

  return resultReturn;

// Old version
  // final List<dynamic> listFourCurentVariants = [];
  // // three random number from arr (except of first)
  // final List<int> listThreerandomNumbers = [counterQuestion];
  // // reslut Mixinly list
  // final List<dynamic> resultList = [];

  // for (var i = 0; i < 3; i++) {
  //   late int curentNum;
  //   do {
  //     curentNum = getRandomNumberIntoList(arr);
  //   } while (listThreerandomNumbers.contains(curentNum) ||
  //       arr[counterQuestion]["firstName"] +
  //               arr[counterQuestion]["patronymicName"] ==
  //           arr[curentNum]["firstName"] + arr[curentNum]["patronymicName"]);
  //   listThreerandomNumbers.add(curentNum);
  // }
  // // create unique JSON items
  // listThreerandomNumbers.forEach((item) {
  //   listFourCurentVariants.add(arr[item]);
  // });

  // // mixing arr consisting from four item
  // final List<int> fourRandom = getFourRandomNumberFromZeroToThree();
  // fourRandom.forEach((item) {
  //   resultList.add(listFourCurentVariants[item]);
  // });

  // return resultList;
}

bool? arrIsEmpty(List<dynamic> arr) {
  return arr.isEmpty;
}

double? progressBarProcent(
  String difficult,
  int counter,
) {
  final int count = counter + 1;
  final int dif = int.parse(difficult);
  return (count / dif).toDouble();
}

List<dynamic> getAllBooksEng() {
  const List<Map> allBooks = [
    {'title': 'Underdog', 'authorId': '1ФонвизинДенисИванович'},
    {'title': 'Monument', 'authorId': '2ДержавинГавриилРоманович'},
    {'title': 'Sea', 'authorId': '3ЖуковскийВасилийАндреевич'},
    {'title': 'Svetlana', 'authorId': '3ЖуковскийВасилийАндреевич'},
    {'title': 'Woe from Wit', 'authorId': '4ГрибоедовАлександрСергеевич'},
    {'title': 'The Village', 'authorId': '5ПушкинАлександрСергеевич'},
    {'title': 'Prisoner', 'authorId': '5ПушкинАлександрСергеевич'},
    {
      'title': 'In the depths of the Siberian ores...',
      'authorId': '5ПушкинАлександрСергеевич'
    },
    {'title': 'The Poet', 'authorId': '5ПушкинАлександрСергеевич'},
    {'title': 'To Chaadayev', 'authorId': '5ПушкинАлександрСергеевич'},
    {
      'title': 'Song of Oleg the Prophetic',
      'authorId': '5ПушкинАлександрСергеевич'
    },
    {'title': 'To the Sea', 'authorId': '5ПушкинАлександрСергеевич'},
    {'title': 'The Nanny', 'authorId': '5ПушкинАлександрСергеевич'},
    {
      'title': 'I remember a marvellous moment...',
      'authorId': '5ПушкинАлександрСергеевич'
    },
    {
      'title': 'The forest throws down its scarlet cloak...',
      'authorId': '5ПушкинАлександрСергеевич'
    },
    {'title': 'The Prophet', 'authorId': '5ПушкинАлександрСергеевич'},
    {'title': 'Winter road', 'authorId': '5ПушкинАлександрСергеевич'},
    {'title': 'Anchor', 'authorId': '5ПушкинАлександрСергеевич'},
    {
      'title': 'On the hills of Georgia lies the night gloom...',
      'authorId': '5ПушкинАлександрСергеевич'
    },
    {
      'title': 'I have loved you: love still...',
      'authorId': '5ПушкинАлександрСергеевич'
    },
    {'title': '...may yet...', 'authorId': '5ПушкинАлександрСергеевич'},
    {'title': 'Winter Morning', 'authorId': '5ПушкинАлександрСергеевич'},
    {'title': 'Demons', 'authorId': '5ПушкинАлександрСергеевич'},
    {
      'title': 'Conversation between a bookseller and a poet',
      'authorId': '5ПушкинАлександрСергеевич'
    },
    {'title': 'Cloud', 'authorId': '5ПушкинАлександрСергеевич'},
    {
      'title': 'I have erected a monument to myself...',
      'authorId': '5ПушкинАлександрСергеевич'
    },
    {
      'title': 'The sun of day is out...',
      'authorId': '5ПушкинАлександрСергеевич'
    },
    {
      'title': 'The sower of liberty is deserted...',
      'authorId': '5ПушкинАлександрСергеевич'
    },
    {
      'title': 'And the weary traveler murmured against God...',
      'authorId': '5ПушкинАлександрСергеевич'
    },
    {
      'title': "The mad years' joys have faded...",
      'authorId': '5ПушкинАлександрСергеевич'
    },
    {
      'title': '...Once again I have visited....',
      'authorId': '5ПушкинАлександрСергеевич'
    },
    {'title': 'Elegy', 'authorId': '5ПушкинАлександрСергеевич'},
    {
      'title': "The Captain's Daughter",
      'authorId': '5ПушкинАлександрСергеевич'
    },
    {'title': 'The Bronze Horseman', 'authorId': '5ПушкинАлександрСергеевич'},
    {'title': 'Eugene Onegin', 'authorId': '5ПушкинАлександрСергеевич'},
    {
      'title': 'Song about... Merchant Kalashnikov',
      'authorId': '6ЛермонтовМихаилЮрьевич'
    },
    {'title': 'Mtsyri', 'authorId': '6ЛермонтовМихаилЮрьевич'},
    {'title': 'A Hero of Our Time', 'authorId': '6ЛермонтовМихаилЮрьевич'},
    {
      'title': "No, I'm not Byron, I'm different...",
      'authorId': '6ЛермонтовМихаилЮрьевич'
    },
    {'title': 'Clouds', 'authorId': '6ЛермонтовМихаилЮрьевич'},
    {'title': 'Beggar', 'authorId': '6ЛермонтовМихаилЮрьевич'},
    {
      'title': 'From under a mysterious, cold half-mask...',
      'authorId': '6ЛермонтовМихаилЮрьевич'
    },
    {'title': 'Sail', 'authorId': '6ЛермонтовМихаилЮрьевич'},
    {'title': 'Death of a Poet', 'authorId': '6ЛермонтовМихаилЮрьевич'},
    {'title': 'Borodino', 'authorId': '6ЛермонтовМихаилЮрьевич'},
    {
      'title': 'When the yellowing grass waves...',
      'authorId': '6ЛермонтовМихаилЮрьевич'
    },
    {'title': 'Thought', 'authorId': '6ЛермонтовМихаилЮрьевич'},
    {
      'title': 'The Poet (My dagger glitters with gold trim...)',
      'authorId': '6ЛермонтовМихаилЮрьевич'
    },
    {'title': 'Three Palms', 'authorId': '6ЛермонтовМихаилЮрьевич'},
    {
      'title': 'Prayer (When life is hard...)',
      'authorId': '6ЛермонтовМихаилЮрьевич'
    },
    {'title': 'And bored and sad', 'authorId': '6ЛермонтовМихаилЮрьевич'},
    {
      'title': "No, I don't love you so fervently...",
      'authorId': '6ЛермонтовМихаилЮрьевич'
    },
    {'title': 'Motherland', 'authorId': '6ЛермонтовМихаилЮрьевич'},
    {
      'title': 'Dream (In the mid-day heat in the valley of Dagestan...)',
      'authorId': '6ЛермонтовМихаилЮрьевич'
    },
    {'title': 'Prophet', 'authorId': '6ЛермонтовМихаилЮрьевич'},
    {
      'title': 'How often, surrounded by a motley crowd...',
      'authorId': '6ЛермонтовМихаилЮрьевич'
    },
    {'title': 'Valerik', 'authorId': '6ЛермонтовМихаилЮрьевич'},
    {
      'title': 'I go out alone on the road....',
      'authorId': '6ЛермонтовМихаилЮрьевич'
    },
    {'title': 'The Inspector', 'authorId': '7ГогольНиколайВасильевич'},
    {'title': 'Overcoat', 'authorId': '7ГогольНиколайВасильевич'},
    {'title': 'Dead Souls', 'authorId': '7ГогольНиколайВасильевич'},
    {'title': 'Thunderstorm', 'authorId': '8ОстровскийАлександрНиколаевич'},
    {'title': 'Fathers and Children', 'authorId': '9ТургеневИванСергеевич'},
    {'title': 'Noon', 'authorId': '10ТютчевФёдорИванович'},
    {
      'title': "There's a tunefulness in the sea waves...",
      'authorId': '10ТютчевФёдорИванович'
    },
    {
      'title': 'From the clearing the kite has risen...',
      'authorId': '10ТютчевФёдорИванович'
    },
    {
      'title': 'There is in the original autumn...',
      'authorId': '10ТютчевФёдорИванович'
    },
    {'title': 'Silentium!', 'authorId': '10ТютчевФёдорИванович'},
    {
      'title': 'Not what you think, nature...',
      'authorId': '10ТютчевФёдорИванович'
    },
    {
      'title': "You can't understand Russia with your mind...",
      'authorId': '10ТютчевФёдорИванович'
    },
    {
      'title': 'Oh, how murderously we love...',
      'authorId': '10ТютчевФёдорИванович'
    },
    {'title': "We can't predict...", 'authorId': '10ТютчевФёдорИванович'},
    {
      'title': "I've met you and all the past...",
      'authorId': '10ТютчевФёдорИванович'
    },
    {
      'title': 'Nature is a sphinx. And all the more true...',
      'authorId': '10ТютчевФёдорИванович'
    },
    {
      'title': 'Dawn says goodbye to the earth',
      'authorId': '11ФетАфанасийАфанасьевич'
    },
    {
      'title': 'One push to bring down the rook of life...',
      'authorId': '11ФетАфанасийАфанасьевич'
    },
    {'title': 'Evening', 'authorId': '11ФетАфанасийАфанасьевич'},
    {
      'title': 'Learn from them - the oak, the birch...',
      'authorId': '11ФетАфанасийАфанасьевич'
    },
    {
      'title': 'This morning, this joy...',
      'authorId': '11ФетАфанасийАфанасьевич'
    },
    {
      'title': 'Whispering, timid breathing...',
      'authorId': '11ФетАфанасийАфанасьевич'
    },
    {
      'title':
          'The night was shining. The garden was full of moonlight. Lying...',
      'authorId': '11ФетАфанасийАфанасьевич'
    },
    {'title': 'Another May night', 'authorId': '11ФетАфанасийАфанасьевич'},
    {'title': 'Oblomov', 'authorId': '12ГончаровИванАлександрович'},
    {'title': 'Troika', 'authorId': '13НекрасовНиколайАлексеевич'},
    {
      'title': 'I do not love your irony...',
      'authorId': '13НекрасовНиколайАлексеевич'
    },
    {'title': 'The railroad', 'authorId': '13НекрасовНиколайАлексеевич'},
    {'title': 'On the road', 'authorId': '13НекрасовНиколайАлексеевич'},
    {
      'title': "Yesterday afternoon, at six o'clock...",
      'authorId': '13НекрасовНиколайАлексеевич'
    },
    {
      'title': 'You and I are foolish men...',
      'authorId': '13НекрасовНиколайАлексеевич'
    },
    {'title': 'Poet and Citizen', 'authorId': '13НекрасовНиколайАлексеевич'},
    {
      'title': 'Elegy (Let the fickle fashion tell us...)',
      'authorId': '13НекрасовНиколайАлексеевич'
    },
    {
      'title': "O Muse! I'm at the door of the coffin...",
      'authorId': '13НекрасовНиколайАлексеевич'
    },
    {
      'title': 'Who lives well in Russia?',
      'authorId': '13НекрасовНиколайАлексеевич'
    },
    {
      'title': 'A Tale of How One Man Fed Two Generals',
      'authorId': '14СалтыковЩедринМихаилЕвграфович'
    },
    {'title': 'Wild landlord', 'authorId': '14СалтыковЩедринМихаилЕвграфович'},
    {
      'title': 'The Wise Squeak',
      'authorId': '14СалтыковЩедринМихаилЕвграфович'
    },
    {
      'title': 'The Story of a Town',
      'authorId': '14СалтыковЩедринМихаилЕвграфович'
    },
    {'title': 'War and Peace', 'authorId': '15ТолстойЛевНиколаевич'},
    {
      'title': 'Crime and Punishment',
      'authorId': '16ДостоевскийФёдорМихайлович'
    },
    {'title': 'Lefty', 'authorId': '17ЛесковНиколайСемёнович'},
    {'title': 'Student', 'authorId': '18ЧеховАнтонПавлович'},
    {'title': 'Ionych', 'authorId': '18ЧеховАнтонПавлович'},
    {'title': 'Man in a box', 'authorId': '18ЧеховАнтонПавлович'},
    {'title': 'Lady with a Dog', 'authorId': '18ЧеховАнтонПавлович'},
    {'title': 'Death of an official', 'authorId': '18ЧеховАнтонПавлович'},
    {'title': 'Chameleon', 'authorId': '18ЧеховАнтонПавлович'},
    {'title': 'The Cherry Orchard', 'authorId': '18ЧеховАнтонПавлович'},
    {'title': 'Mister from San Francisco', 'authorId': '19БунинИванАлексеевич'},
    {'title': 'Clean Monday', 'authorId': '19БунинИванАлексеевич'},
    {'title': 'Old Woman Isergil', 'authorId': '20ПешковМаксимГорький'},
    {'title': 'At the bottom', 'authorId': '20ПешковМаксимГорький'},
    {'title': 'Stranger', 'authorId': '21БлокАлександрАлександрович'},
    {'title': 'Russia', 'authorId': '21БлокАлександрАлександрович'},
    {
      'title': 'Night, street, streetlight, drugstore...',
      'authorId': '21БлокАлександрАлександрович'
    },
    {'title': 'In a restaurant.', 'authorId': '21БлокАлександрАлександрович'},
    {
      'title': 'The river stretches out. Flowing, sad and lazy...',
      'authorId': '21БлокАлександрАлександрович'
    },
    {'title': 'On the railroad', 'authorId': '21БлокАлександрАлександрович'},
    {
      'title': 'I enter the dark temples...',
      'authorId': '21БлокАлександрАлександрович'
    },
    {'title': 'Factory', 'authorId': '21БлокАлександрАлександрович'},
    {'title': 'Russia', 'authorId': '21БлокАлександрАлександрович'},
    {
      'title': 'Of valor, of deeds, of glory...',
      'authorId': '21БлокАлександрАлександрович'
    },
    {
      'title': 'Oh, I want to live madly...',
      'authorId': '21БлокАлександрАлександрович'
    },
    {'title': 'Twelve', 'authorId': '21БлокАлександрАлександрович'},
    {'title': 'Could you?', 'authorId': '22МаяковскийВладимирВладимирович'},
    {'title': 'Listen!', 'authorId': '22МаяковскийВладимирВладимирович'},
    {
      'title': 'Violin and a little nervously.',
      'authorId': '22МаяковскийВладимирВладимирович'
    },
    {'title': 'Lilichka!', 'authorId': '22МаяковскийВладимирВладимирович'},
    {'title': 'Jubilee', 'authorId': '22МаяковскийВладимирВладимирович'},
    {'title': 'Prossed', 'authorId': '22МаяковскийВладимирВладимирович'},
    {'title': 'Here we go!', 'authorId': '22МаяковскийВладимирВладимирович'},
    {
      'title': 'Good attitude to horses',
      'authorId': '22МаяковскийВладимирВладимирович'
    },
    {'title': 'Cheap sale', 'authorId': '22МаяковскийВладимирВладимирович'},
    {
      'title': 'Letter to Tatyana Yakovleva',
      'authorId': '22МаяковскийВладимирВладимирович'
    },
    {
      'title': 'A Cloud in Your Pants',
      'authorId': '22МаяковскийВладимирВладимирович'
    },
    {
      'title': 'Gye you, Russia, my dear!',
      'authorId': '23ЕсенинСергейАлександрович'
    },
    {
      'title': 'Not to wander, not to crumple in the scarlet bushes...',
      'authorId': '23ЕсенинСергейАлександрович'
    },
    {
      'title': "We're going away now, little by little...",
      'authorId': '23ЕсенинСергейАлександрович'
    },
    {'title': 'Letter to mother...', 'authorId': '23ЕсенинСергейАлександрович'},
    {
      'title': 'The feather-grass sleeps. The plain dear...',
      'authorId': '23ЕсенинСергейАлександрович'
    },
    {
      'title': 'Shagane, my Shagane...',
      'authorId': '23ЕсенинСергейАлександрович'
    },
    {
      'title': "I don't pity, I don't call, I don't cry...",
      'authorId': '23ЕсенинСергейАлександрович'
    },
    {'title': 'Soviet Russia...', 'authorId': '23ЕсенинСергейАлександрович'},
    {
      'title': 'The road was thinking of a red evening...',
      'authorId': '23ЕсенинСергейАлександрович'
    },
    {
      'title': 'The hewn drogues have sung...',
      'authorId': '23ЕсенинСергейАлександрович'
    },
    {'title': 'Rus', 'authorId': '23ЕсенинСергейАлександрович'},
    {'title': 'Pushkin', 'authorId': '23ЕсенинСергейАлександрович'},
    {
      'title': "I'm walking down a valley. Cap on the back of my neck...",
      'authorId': '23ЕсенинСергейАлександрович'
    },
    {
      'title': 'Low house with blue shutters',
      'authorId': '23ЕсенинСергейАлександрович'
    },
    {
      'title': 'My poems, written so early...',
      'authorId': '24ЦветаеваМаринаИвановна'
    },
    {'title': 'Poems to Blok', 'authorId': '24ЦветаеваМаринаИвановна'},
    {
      'title': 'Who is made of stone, who is made of clay...',
      'authorId': '24ЦветаеваМаринаИвановна'
    },
    {
      'title': 'Longing for my homeland! Long ago...',
      'authorId': '24ЦветаеваМаринаИвановна'
    },
    {'title': 'Books in a red binding', 'authorId': '24ЦветаеваМаринаИвановна'},
    {'title': 'To Grandma', 'authorId': '24ЦветаеваМаринаИвановна'},
    {
      'title': 'Seven hills, like seven bells!',
      'authorId': '24ЦветаеваМаринаИвановна'
    },
    {'title': 'Notre Dame', 'authorId': '25МандельштамОсипЭмильевич'},
    {
      'title': 'Insomnia. Homer. Tight sails...',
      'authorId': '25МандельштамОсипЭмильевич'
    },
    {
      'title': 'To the rattling valor of centuries to come...',
      'authorId': '25МандельштамОсипЭмильевич'
    },
    {
      'title': 'I have returned to my city, familiar to tears...',
      'authorId': '25МандельштамОсипЭмильевич'
    },
    {
      'title': 'The song of the last meeting',
      'authorId': '26АхматоваАннаАндреевна'
    },
    {
      'title': 'Clenched my hands beneath a dark veil...',
      'authorId': '26АхматоваАннаАндреевна'
    },
    {
      'title': 'I have no need for odious slaves...',
      'authorId': '26АхматоваАннаАндреевна'
    },
    {
      'title': 'I had a voice. It called comfortingly...',
      'authorId': '26АхматоваАннаАндреевна'
    },
    {'title': 'My native land...', 'authorId': '26АхматоваАннаАндреевна'},
    {
      'title': 'Weeping autumn, like a widow...',
      'authorId': '26АхматоваАннаАндреевна'
    },
    {'title': 'A seaside sonnet', 'authorId': '26АхматоваАннаАндреевна'},
    {
      'title': 'There are days before spring...',
      'authorId': '26АхматоваАннаАндреевна'
    },
    {
      'title': 'I am not with those who have abandoned the earth...',
      'authorId': '26АхматоваАннаАндреевна'
    },
    {
      'title': 'Poems about St. Petersburg',
      'authorId': '26АхматоваАннаАндреевна'
    },
    {'title': 'Courage', 'authorId': '26АхматоваАннаАндреевна'},
    {'title': 'Requiem', 'authorId': '26АхматоваАннаАндреевна'},
    {'title': 'Quiet Don', 'authorId': '27ШолоховМихаилАлександрович'},
    {'title': 'The Fate of Man', 'authorId': '27ШолоховМихаилАлександрович'},
    {'title': 'White Guard', 'authorId': '28БулгаковМихаилАфанасьевич'},
    {
      'title': 'The Master and Margarita',
      'authorId': '28БулгаковМихаилАфанасьевич'
    },
    {
      'title': 'The essence in a single testament ...',
      'authorId': '29ТвардовскийАлександрТрифонович'
    },
    {
      'title': 'To the memory of my mother.',
      'authorId': '29ТвардовскийАлександрТрифонович'
    },
    {
      'title': "I know it's not my fault ...",
      'authorId': '29ТвардовскийАлександрТрифонович'
    },
    {
      'title': 'Vasiliy Tyorkin.',
      'authorId': '29ТвардовскийАлександрТрифонович'
    },
    {
      'title': 'February. Take out the ink and cry!',
      'authorId': '30ПастернакБорисЛеонидович'
    },
    {
      'title': 'The definition of poetry',
      'authorId': '30ПастернакБорисЛеонидович'
    },
    {
      'title': 'In everything I want to reach...',
      'authorId': '30ПастернакБорисЛеонидович'
    },
    {'title': 'Hamlet', 'authorId': '30ПастернакБорисЛеонидович'},
    {'title': 'A winter night...', 'authorId': '30ПастернакБорисЛеонидович'},
    {
      'title': 'No one will be in the house...',
      'authorId': '30ПастернакБорисЛеонидович'
    },
    {'title': "It's snowing", 'authorId': '30ПастернакБорисЛеонидович'},
    {'title': 'About these poems...', 'authorId': '30ПастернакБорисЛеонидович'},
    {
      'title': 'To love others is a heavy cross...',
      'authorId': '30ПастернакБорисЛеонидович'
    },
    {'title': 'Pines', 'authorId': '30ПастернакБорисЛеонидович'},
    {'title': 'Frost', 'authorId': '30ПастернакБорисЛеонидович'},
    {'title': 'July', 'authorId': '30ПастернакБорисЛеонидович'},
    {'title': 'Doctor Zhivago', 'authorId': '30ПастернакБорисЛеонидович'},
    {'title': "Matryonin's Yard", 'authorId': '32СолженицынАлександрИсаевич'},
    {
      'title': 'One Day in the Life of Ivan Denisovich',
      'authorId': '32СолженицынАлександрИсаевич'
    },
    {'title': 'Kolyma Tales', 'authorId': '35ШаламовВарламТихонович'},
    {'title': 'We', 'authorId': '34ЗамятинЕвгенийИванович'},
    {'title': 'Wooden Horses', 'authorId': '36АбрамовФёдорАлександрович'},
    {
      'title': 'A Cloud, a Lake, and a Tower',
      'authorId': '37НабоковВладимирВладимирович'
    },
    {'title': 'Spring in Fialte.', 'authorId': '37НабоковВладимирВладимирович'},
    {
      'title': 'And the day lasts longer than a century.',
      'authorId': '38АйтматовЧингизТорекулович'
    },
    {'title': 'Plaque', 'authorId': '38АйтматовЧингизТорекулович'},
    {'title': 'The King-fish', 'authorId': '39АстафьевВикторПетрович'},
    {'title': 'Sotnikov', 'authorId': '40БыковВасильВладимирович'},
    {'title': 'Obelisk', 'authorId': '40БыковВасильВладимирович'},
    {'title': 'Life and Destiny', 'authorId': '41ГроссманВасилийСемёнович'},
    {'title': 'Sanctuary', 'authorId': '42ДовлатовСергейДонатович'},
    {'title': 'Compromise', 'authorId': '42ДовлатовСергейДонатович'},
    {'title': 'Sashka', 'authorId': '43КондратьевВячеславЛеонидович'},
    {
      'title': 'Farewell to Matyora',
      'authorId': '45РаспутинВалентинГригорьевич'
    },
    {'title': 'Payback', 'authorId': '46ТендряковВладимирФёдорович'},
    {
      'title': 'House on the Embankment',
      'authorId': '47ТрифоновЮрийВалентинович'
    },
    {'title': 'Cut', 'authorId': '48ШукшинВасилийМакарович'},
    {'title': 'Geek', 'authorId': '48ШукшинВасилийМакарович'},
    {'title': 'Stuck', 'authorId': '48ШукшинВасилийМакарович'},
    {'title': 'Autumn', 'authorId': '49АхмадулинаБеллаАхатовна'},
    {'title': 'Night', 'authorId': '49АхмадулинаБеллаАхатовна'},
    {'title': "We're breaking up", 'authorId': '49АхмадулинаБеллаАхатовна'},
    {'title': 'Pilgrims', 'authorId': '50БродскийИосифАлександрович'},
    {
      'title': "Don't leave the room...",
      'authorId': '50БродскийИосифАлександрович'
    },
    {
      'title': 'No country, no pogost...',
      'authorId': '50БродскийИосифАлександрович'
    },
    {
      'title': 'A Christmas Romance',
      'authorId': '50БродскийИосифАлександрович'
    },
    {
      'title': 'To the death of Zhukov',
      'authorId': '50БродскийИосифАлександрович'
    },
    {
      'title': 'I entered instead of a wild beast into a cage...',
      'authorId': '50БродскийИосифАлександрович'
    },
    {
      'title': "In the village God doesn't live in corners...",
      'authorId': '50БродскийИосифАлександрович'
    },
    {
      'title': 'The end of a beautiful era',
      'authorId': '50БродскийИосифАлександрович'
    },
    {
      'title': 'Going back to your homeland. Well...',
      'authorId': '50БродскийИосифАлександрович'
    },
    {
      'title': 'On the centenary of Anna Akhmatova',
      'authorId': '50БродскийИосифАлександрович'
    },
    {
      'title': "It's not the Muse that takes water in her mouth...",
      'authorId': '50БродскийИосифАлександрович'
    },
    {'title': 'Saga', 'authorId': '51ВознесенскийАндрейАндреевич'},
    {'title': 'The Commandment', 'authorId': '51ВознесенскийАндрейАндреевич'},
    {'title': "Ophelia's Song", 'authorId': '51ВознесенскийАндрейАндреевич'},
    {'title': 'Song about a Friend', 'authorId': '52ВысоцкийВладимирСемёнович'},
    {'title': "I don't love", 'authorId': '52ВысоцкийВладимирСемёнович'},
    {'title': 'My dog', 'authorId': '53ЕвтушенкоЕвгенийАлександрович'},
    {'title': 'To women', 'authorId': '53ЕвтушенкоЕвгенийАлександрович'},
    {
      'title': 'Censorship by indifference',
      'authorId': '53ЕвтушенкоЕвгенийАлександрович'
    },
    {'title': 'Bratskaya GES', 'authorId': '53ЕвтушенкоЕвгенийАлександрович'},
    {
      'title': "Don't let your soul be lazy",
      'authorId': '54ЗаболоцкийНиколайАлексеевич'
    },
    {'title': "On New Year's Eve", 'authorId': '54ЗаболоцкийНиколайАлексеевич'},
    {'title': 'Old actress', 'authorId': '54ЗаболоцкийНиколайАлексеевич'},
    {'title': 'Georgian song', 'authorId': '55ОкуджаваБулатШалвович'},
    {'title': 'The poet has no rivals', 'authorId': '55ОкуджаваБулатШалвович'},
    {'title': 'Mozart', 'authorId': '55ОкуджаваБулатШалвович'},
    {'title': 'Blue trolleybus', 'authorId': '55ОкуджаваБулатШалвович'},
    {'title': 'Birches', 'authorId': '56РубцовНиколайМихайлович'},
    {'title': 'In an upper room', 'authorId': '56РубцовНиколайМихайлович'},
    {
      'title': "It's time for love in the fields",
      'authorId': '56РубцовНиколайМихайлович'
    },
    {'title': "A friend's voice", 'authorId': '57СлуцкийБорисАбрамович'},
    {'title': 'Dream', 'authorId': '57СлуцкийБорисАбрамович'},
    {'title': 'Conscience', 'authorId': '57СлуцкийБорисАбрамович'},
    {
      'title': "Don't hide from the rain",
      'authorId': '58СолоухинВладимирАлексеевич'
    },
    {'title': 'Crimson', 'authorId': '59ТарковскийАндрейАрсеньевич'},
    {'title': 'Become yourself', 'authorId': '59ТарковскийАндрейАрсеньевич'},
    {'title': "Summer's over...", 'authorId': '59ТарковскийАндрейАрсеньевич'},
    {'title': 'Tanya', 'authorId': '60АрбузовАлексейНиколаевич'},
    {'title': 'Brutal games', 'authorId': '60АрбузовАлексейНиколаевич'},
    {'title': 'Duck Hunt', 'authorId': '61ВампиловАлександрВалентинович'},
    {'title': 'eldest son', 'authorId': '61ВампиловАлександрВалентинович'},
    {
      'title': "Don't part with your loved ones",
      'authorId': '62ВолодинАлександрМоисеевич'
    },
    {'title': 'Destination', 'authorId': '62ВолодинАлександрМоисеевич'},
    {'title': 'Valentine and Valentine', 'authorId': '63РощинМихаилМихайлович'}
  ];
  return allBooks;
}

int incrementInt(int counterQ) {
  return counterQ + 1;
}

List<String>? deleteLastIndexArr(List<String> arr) {
  late List<String> newArr = [];
  for (var i = 0; i < arr.length - 1; i++) {
    newArr.add(arr[i]);
  }
  return newArr;
}

List<dynamic> booksGetFourItems(
  List<dynamic> arrAuthors,
  String myId,
  String idAuthor,
) {
  var filteredList = [];
  var matchFound = false;
  var random = math.Random();
  var matchingAuthor = arrAuthors.where((a) => a[myId] == idAuthor);
  var nonMatchingAuthors = arrAuthors.where((a) => a[myId] != idAuthor);

  var resultList = [];
  // var filteredList = [];
  // var random = new math.Random();
  // var matchFound = false;
  // var matchingAuthor = arrAuthors.where((a) => a[myId] == idAuthor);

  if (matchingAuthor.length > 0) {
    filteredList.add(matchingAuthor.first);
    matchFound = true;
  }

  while (filteredList.length < 4) {
    var randomIndex = random.nextInt(nonMatchingAuthors.length);
    filteredList.add(nonMatchingAuthors.elementAt(randomIndex));
  }

  // mixing arr consisting from four item
  final List<int> fourRandom = getFourRandomNumberFromZeroToThree();
  fourRandom.forEach((item) {
    resultList.add(filteredList[item]);
  });

  return resultList;
}

String intArrSumToString(List<int> intArr) {
  return intArr.reduce((a, b) => a + b).toString();
}

dynamic getUserStats(UsersStatisticStruct? userStats) {
  return {
    "experience": userStats?.usersLevel,
    "points": userStats?.usersPoints,
    "countersGame": [
      {"namesGameCounter": userStats?.usersGames.namesGameCounter},
      {"booksGameCounter": userStats?.usersGames.booksGameCounter},
      {"imagesGameCounter": userStats?.usersGames.imagesGameCounter},
    ],
  };
}

List<int> getUsersGamesCounters(UsersStatisticStruct? userStats) {
  return [
    userStats?.usersGames.booksGameCounter ?? 0,
    // userStats?.usersGames.namesGameCounter ?? 0,
    userStats?.usersGames.imagesGameCounter ?? 0
  ];
}

int getUsersLevel(int? playerExperience) {
  final experience = playerExperience ?? 1;
  int level = 1;
  int requiredExperience = 0;
  while (experience >= requiredExperience) {
    requiredExperience += 100 + (15 * (level));
    requiredExperience = requiredExperience.round();
    level++;
  }
  return level - 1;
}

List<dynamic> namesGetTwoItems(
  List<dynamic> currentArr,
  int currentQuestion,
  List<dynamic> allArr,
) {
  // new vesrion
  final random = new math.Random();
  // final filteredArr = allArr
  //     .where(
  //         (element) => element["myId"] != currentArr[currentQuestion]["myId"])
  //     .toList();
  final List<dynamic> result = [currentArr[currentQuestion]];
  // final resultNames = [
  //   currentArr[currentQuestion]["firstName"] +
  //       currentArr[currentQuestion]["patronymicName"]
  // ];

  while (result.length < 2) {
    final randomIndex = random.nextInt(allArr.length);
    final randomElement = allArr[randomIndex];
    // final randomElementName = allArr[randomIndex]["firstName"] +
    //     allArr[randomIndex]["patronymicName"];
    if (!result.contains(randomElement)) {
      result.add(randomElement);
    }
  }

  if (random.nextBool()) {
    return [result[0], result[1]];
  } else {
    return [result[1], result[0]];
  }
}

List<dynamic> namesGetOneItems(
  List<dynamic> arr,
  int counterQuestion,
) {
  return [arr[counterQuestion]];
}

int calculateRequiredExperience(int? levelUser) {
  int requiredExperience = 0;
  final levelPlayer = levelUser ?? 1;
  for (int i = 1; i <= levelPlayer; i++) {
    requiredExperience += 100 + (15 * (i));
    requiredExperience = requiredExperience.round();
  }
  return requiredExperience;
}

double calculatePercentToNextLevel(
  int? usersLevel,
  int? curentExp,
) {
  final int levelPlayer = usersLevel ?? 1;
  // subtract experience so that only the experience needed for the next
  // level remains
  final int expMinusOne = calculateRequiredExperience(levelPlayer - 1);
  final int expToNextLevel = calculateRequiredExperience(levelPlayer);
  final initialExp = (curentExp ?? 1) - expMinusOne;
  final requerExp = expToNextLevel - expMinusOne;

  // print([levelPlayer, (curentExp ?? 1)]);
  // print([expMinusOne, expToNextLevel]);
  // print([initialExp, requerExp]);
  return (initialExp / requerExp) >= 0 && (initialExp / requerExp) <= 1
      ? (initialExp / requerExp)
      : 0;
}

String? testRender() {
  print("Render");
  // return print("Render");
}

List<dynamic> booksGetTwoItems(
  List<dynamic> arrAuthors,
  String myId,
  String idAuthor,
) {
  final filteredList = [];
  var matchFound = false;
  final random = math.Random();
  final matchingAuthor = arrAuthors.where((a) => a[myId] == idAuthor);
  final nonMatchingAuthors = arrAuthors.where((a) => a[myId] != idAuthor);
  // final result = [];

  if (matchingAuthor.length > 0) {
    filteredList.add(matchingAuthor.first);
    matchFound = true;
  }

  while (filteredList.length < 2) {
    final randomIndex = random.nextInt(nonMatchingAuthors.length);
    filteredList.add(nonMatchingAuthors.elementAt(randomIndex));
  }

  // mixing arr consisting from four item
  if (random.nextBool()) {
    return [filteredList[0], filteredList[1]];
  } else {
    return [filteredList[1], filteredList[0]];
  }
}

List<dynamic> booksGetOneItems(
  List<dynamic> arrAuthors,
  String myId,
  String idAuthor,
) {
  final filteredList = [];
  final matchingAuthor = arrAuthors.where((a) => a[myId] == idAuthor);
  // final result = [];
  filteredList.add(matchingAuthor.first);
  return filteredList;
}

String createAnonumName() {
  int randomNumber = 1000 + (math.Random().nextInt(100000 - 1000));
  return 'User$randomNumber';
}
