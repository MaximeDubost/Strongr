import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strongr/widgets/strongr_text.dart';

class LegalNoticeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> legalNotice = {
      "Définitions": [
        "Client : tout professionnel ou personne physique capable au sens des articles 1123 et suivants du Code civil, ou personne morale, qui visite l'application objet des présentes conditions générales.",
        "Prestations et Services : Strongr met à disposition des Clients.",
        "Contenu : Ensemble des éléments constituants l’information présente sur l'application, notamment textes – images – vidéos.",
        "Informations clients : Ci-après dénommé « Information(s) » qui correspondent à l’ensemble des données personnelles susceptibles d’être détenues par Strongr pour la gestion de votre compte, de la gestion de la relation client et à des fins d’analyses et de statistiques.",
        "Utilisateur : Personne se connectant, utilisant l’application susnommé.",
        "Informations personnelles : « Les informations qui permettent, sous quelque forme que ce soit, directement ou non, l'identification des personnes physiques auxquelles elles s'appliquent » (article 4 de la loi n° 78-17 du 6 janvier 1978).",
        "Les termes « données à caractère personnel », « personne concernée », « sous-traitant » et « données sensibles » ont le sens défini par le Règlement Général sur la Protection des Données (RGPD : n° 2016-679)",
      ],
      "1.	Présentation de l’application ": [
        "En vertu de l'article 6 de la loi n° 2004-575 du 21 juin 2004 pour la confiance dans l'économie numérique, il est précisé aux utilisateurs de l'application Strongr l'identité des différents intervenants dans le cadre de sa réalisation et de son suivi :",
        "Propriétaire : SAS DevApp Capital social de 13000€ Numéro de TVA: FR89676464063 – 88 Boulevard Gallieni 92130 ISSY LES MOULINEAUX",
        "Responsable publication : Aurélien Guillemot – aurelienguillemot@hotmail.fr. Le responsable publication est une personne physique ou une personne morale.",
        "Webmaster : Maxime Dubost – maxime.dubost.75@gmail.com",
        "Hébergeur : Heroku – 88 Boulevard Gallieni 92130 ISSY LES MOULINEAUX 06 37 95 42 73",
        "Délégué à la protection des données : Tsi Kévin – kevtsiii@gmail.com",
      ],
      "2.	Conditions générales d’utilisation de l’application et des services proposés":
          [
        "L’application constitue une œuvre de l’esprit protégée par les dispositions du Code de la Propriété Intellectuelle et des Réglementations Internationales applicables. Le Client ne peut en aucune manière réutiliser, céder ou exploiter pour son propre compte tout ou partie des éléments ou travaux de l’application.",
        "L’utilisation de l’application Strongr implique l’acceptation pleine et entière des conditions générales d’utilisation ci-après décrites. Ces conditions d’utilisation sont susceptibles d’être modifiées ou complétées à tout moment, les utilisateurs de l’application Strongr sont donc invités à les consulter de manière régulière.",
        "Cette application est normalement accessible à tout moment aux utilisateurs. Une interruption pour raison de maintenance technique peut être toutefois décidée par Strongr qui s’efforcera alors de communiquer préalablement aux utilisateurs les dates et heures de l’intervention. L’application Strongr est mise à jour régulièrement par Strongr responsable. De la même façon, les mentions légales peuvent être modifiées à tout moment : elles s’imposent néanmoins à l’utilisateur qui est invité à s’y référer le plus souvent possible afin d’en prendre connaissance.",
      ],
      "3.	Description des services fournis ": [
        "L’application Strongr a pour objet de fournir une information concernant l’ensemble des activités de la société. Strongr s’efforce de fournir sur l’application des informations aussi précises que possible. Toutefois, il ne pourra être tenu responsable des oublis, des inexactitudes et des carences dans la mise à jour, qu’elles soient de son fait ou du fait des tiers partenaires qui lui fournissent ces informations.",
        "Toutes les informations indiquées sur l’application Strongr sont données à titre indicatif, et sont susceptibles d’évoluer. Par ailleurs, les renseignements figurant sur l’application Strongr ne sont pas exhaustifs. Ils sont donnés sous réserve de modifications ayant été apportées depuis leur mise en ligne.",
      ],
      "4.	Limitations contractuelles sur les données techniques": [
        "L’application utilise la technologie JavaScript. L’application ne pourra être tenu responsable de dommages matériels liés à l’utilisation de l’application. De plus, l’utilisateur s’engage à accéder à l'application en utilisant un matériel récent, ne contenant pas de virus et avec un téléphone mobile de dernière génération mis-à-jour. L’application Strongr est hébergée chez un prestataire sur le territoire de l’Union Européenne conformément aux dispositions du Règlement Général sur la Protection des Données (RGPD : n° 2016-679)",
        "L’objectif est d’apporter une prestation qui assure le meilleur taux d’accessibilité. L’hébergeur assure la continuité de son service 24 Heures sur 24, tous les jours de l’année. Il se réserve néanmoins la possibilité d’interrompre le service d’hébergement pour les durées les plus courtes possibles notamment à des fins de maintenance, d’amélioration de ses infrastructures, de défaillance de ses infrastructures ou si les Prestations et Services génèrent un trafic réputé anormal.",
        "Strongr et l’hébergeur ne pourront être tenus responsables en cas de dysfonctionnement du réseau Internet, des lignes téléphoniques ou du matériel informatique et de téléphonie liée notamment à l’encombrement du réseau empêchant l’accès au serveur.",
      ],
      "5.	Propriété intellectuelle et contrefaçons.": [
        "Strongr est propriétaire des droits de propriété intellectuelle et détient les droits d’usage sur tous les éléments accessibles sur l’application, notamment les textes, images, graphismes, logos, vidéos, icônes et sons. Toute reproduction, représentation, modification, publication, adaptation de tout ou partie des éléments de l’application, quel que soit le moyen ou le procédé utilisé, est interdite, sauf autorisation écrite préalable de Strongr",
        "Toute exploitation non autorisée de l’application ou de l’un quelconque des éléments qu’il contient sera considérée comme constitutive d’une contrefaçon et poursuivie conformément aux dispositions des articles L.335-2 et suivants du Code de Propriété Intellectuelle.",
      ],
      "6.	Limitations de responsabilité.": [
        "Strongr agit en tant qu’éditeur de l’application. Strongr est responsable de la qualité et de la véracité du Contenu qu’il publie.",
        "Strongr ne pourra être tenu responsable des dommages directs et indirects causés au matériel de l’utilisateur, lors de l’accès à l’application Strongr, et résultant soit de l’utilisation d’un matériel ne répondant pas aux spécifications indiquées au point 4, soit de l’apparition d’un bug ou d’une incompatibilité.",
        "Strongr ne pourra également être tenu responsable des dommages indirects (tels par exemple qu’une perte de marché ou perte d’une chance) consécutifs à l’utilisation de l’application Strongr. Des espaces interactifs (possibilité de poser des questions dans l’espace contact) sont à la disposition des utilisateurs. Strongr se réserve le droit de supprimer, sans mise en demeure préalable, tout contenu déposé dans cet espace qui contreviendrait à la législation applicable en France, en particulier aux dispositions relatives à la protection des données. Le cas échéant Strongr se réserve également la possibilité de mettre en cause la responsabilité civile et/ou pénale de l’utilisateur, notamment en cas de message à caractère raciste, injurieux, diffamant, ou pornographique, quel que soit le support utilisé (texte, photographie …).",
      ],
      "7.	Gestion des données personnelles.": [
        "Le Client est informé des réglementations concernant la communication marketing, la loi du 21 Juin 2014 pour la confiance dans l’Economie Numérique, la Loi Informatique et Liberté du 06 Août 2004 ainsi que du Règlement Général sur la Protection des Données (RGPD : n° 2016-679).",
      ],
      "7.1. Responsables de la collecte des données personnelles": [
        "Pour les Données Personnelles collectées dans le cadre de la création du compte personnel de l’Utilisateur et de sa navigation sur l’application, le responsable du traitement des Données Personnelles est : DevApp. Strongr est représenté par TSI Kévin, son représentant légal.",
        "En tant que responsable du traitement des données qu’il collecte, Strongr s’engage à respecter le cadre des dispositions légales en vigueur. Il lui appartient notamment au Client d’établir les finalités de ses traitements de données, de fournir à ses prospects et clients, à partir de la collecte de leurs consentements, une information complète sur le traitement de leurs données personnelles et de maintenir un registre des traitements conforme à la réalité. Chaque fois que Strongr traite des Données Personnelles, Strongr prend toutes les mesures raisonnables pour s’assurer de l’exactitude et de la pertinence des Données Personnelles au regard des finalités pour lesquelles Strongr les traite.",
      ],
      "7.2 Finalité des données collectées": [
        "Strongr est susceptible de traiter tout ou partie des données :",
        "•	pour permettre la navigation sur l’application et la gestion et la traçabilité des prestations et services commandés par l’utilisateur : données de connexion et d’utilisation de l’application, facturation, historique des commandes, etc.",
        "•	pour prévenir et lutter contre la fraude informatique (spamming, hacking…) : matériel informatique utilisé pour la navigation, l’adresse IP, le mot de passe (hashé)",
        "•	pour améliorer la navigation sur l’application : données de connexion et d’utilisation",
        "•	pour mener des enquêtes de satisfaction facultatives sur Strongr : adresse email",
        "•	pour mener des campagnes de communication (sms, mail) : numéro de téléphone, adresse email",
        "Strongr ne commercialise pas vos données personnelles qui sont donc uniquement utilisées par nécessité ou à des fins statistiques et d’analyses.",
      ],
      "7.3 Droit d’accès, de rectification et d’opposition": [
        "Conformément à la réglementation européenne en vigueur, les Utilisateurs de Strongr disposent des droits suivants :",
        "•	droit d'accès (article 15 RGPD) et de rectification (article 16 RGPD), de mise à jour, de complétude des données des Utilisateurs droit de verrouillage ou d’effacement des données des Utilisateurs à caractère personnel (article 17 du RGPD), lorsqu’elles sont inexactes, incomplètes, équivoques, périmées, ou dont la collecte, l'utilisation, la communication ou la conservation est interdite",
        "•	droit de retirer à tout moment un consentement (article 13-2c RGPD)",
        "•	droit à la limitation du traitement des données des Utilisateurs (article 18 RGPD)",
        "•	droit d’opposition au traitement des données des Utilisateurs (article 21 RGPD)",
        "•	droit à la portabilité des données que les Utilisateurs auront fournies, lorsque ces données font l’objet de traitements automatisés fondés sur leur consentement ou sur un contrat (article 20 RGPD)",
        "•	droit de définir le sort des données des Utilisateurs après leur mort et de choisir à qui Strongr devra communiquer (ou non) ses données à un tiers qu’ils aura préalablement désigné",
        "Dès que Strongr a connaissance du décès d’un Utilisateur et à défaut d’instructions de sa part, Strongr s’engage à détruire ses données, sauf si leur conservation s’avère nécessaire à des fins probatoires ou pour répondre à une obligation légale.",
        "Si l’Utilisateur souhaite savoir comment Strongr utilise ses Données Personnelles, demander à les rectifier ou s’oppose à leur traitement, l’Utilisateur peut contacter Strongr par écrit à l’adresse suivante :",
        "DevApp – DPO, Guillemot, 88 Boulevard Gallieni 92130 ISSY LES MOULINEAUX.",
        "Dans ce cas, l’utilisateur doit indiquer les Données Personnelles qu’il souhaiterait que Strongr corrige, mette à jour ou supprime, en s’identifiant précisément avec une copie d’une pièce d’identité (carte d’identité ou passeport).",
        "Les demandes de suppression de Données Personnelles seront soumises aux obligations qui sont imposées à Strongr par la loi, notamment en matière de conservation ou d’archivage des documents. Enfin, les Utilisateurs de Strongr peuvent déposer une réclamation auprès des autorités de contrôle, et notamment de la CNIL (https://www.cnil.fr/fr/plaintes).",
      ],
      "7.4 Non-communication des données personnelles": [
        "Strongr s’interdit de traiter, héberger ou transférer les Informations collectées sur ses Clients vers un pays situé en dehors de l’Union européenne ou reconnu comme « non adéquat » par la Commission européenne sans en informer préalablement le client. Pour autant, Strongr reste libre du choix de ses sous-traitants techniques et commerciaux à la condition qu’ils présentent les garanties suffisantes au regard des exigences du Règlement Général sur la Protection des Données (RGPD : n° 2016-679).",
        "Strongr s’engage à prendre toutes les précautions nécessaires afin de préserver la sécurité des Informations et notamment qu’elles ne soient pas communiquées à des personnes non autorisées. Cependant, si un incident impactant l’intégrité ou la confidentialité des Informations du Client est portée à la connaissance de Strongr, celle-ci devra dans les meilleurs délais informer le Client et lui communiquer les mesures de corrections prises. Par ailleurs Strongr ne collecte aucune « données sensibles ».",
        "Les Données Personnelles de l’Utilisateur peuvent être traitées par des filiales de Strongr et des sous-traitants (prestataires de services), exclusivement afin de réaliser les finalités de la présente politique.",
        "Dans la limite de leurs attributions respectives et pour les finalités rappelées ci-dessus, les principales personnes susceptibles d’avoir accès aux données des Utilisateurs de Strongr sont principalement les agents de notre service client.",
      ],
      "7.5 Types de données collectées": [
        "Concernant les utilisateurs de l’application Strongr, nous collectons les données suivantes qui sont indispensables au fonctionnement du service, et qui seront conservées pendant une période maximale de 6 mois après la fin de la relation contractuelle : nom, prénom, poids, date de naissance, adresse mail, mot de passe.",
        "Strongr collecte en outre des informations qui permettent d’améliorer l’expérience utilisateur et de proposer des conseils contextualisés.",
        "Ces données sont conservées pour une période maximale de 6 mois après la fin de la relation contractuelle",
      ],
      "8.	Notification d’incident": [
        "Quels que soient les efforts fournis, aucune méthode de transmission sur Internet et aucune méthode de stockage électronique n'est complètement sûre. Nous ne pouvons en conséquence pas garantir une sécurité absolue. Si nous prenions connaissance d'une brèche de la sécurité, nous avertirions les utilisateurs concernés afin qu'ils puissent prendre les mesures appropriées. Nos procédures de notification d’incident tiennent compte de nos obligations légales, qu'elles se situent au niveau national ou européen. Nous nous engageons à informer pleinement nos clients de toutes les questions relevant de la sécurité de leur compte et à leur fournir toutes les informations nécessaires pour les aider à respecter leurs propres obligations réglementaires en matière de reporting.",
        "Aucune information personnelle de l'utilisateur de l’application Strongr n'est publiée à l'insu de l'utilisateur, échangée, transférée, cédée ou vendue sur un support quelconque à des tiers. Seule l'hypothèse du rachat de Strongr et de ses droits permettrait la transmission des dites informations à l'éventuel acquéreur qui serait à son tour tenu de la même obligation de conservation et de modification des données vis à vis de l'utilisateur de l’application Strongr.",
      ],
      "9.	Sécurité": [
        "Pour assurer la sécurité et la confidentialité des Données Personnelles et des Données Personnelles de Santé, Strongr utilise des réseaux protégés par des dispositifs standards tels que par pare-feu, la pseudonymisation, l’encryption et mot de passe.",
        "Lors du traitement des Données Personnelles, Strongr prend toutes les mesures raisonnables visant à les protéger contre toute perte, utilisation détournée, accès non autorisé, divulgation, altération ou destruction.",
      ],
      "Mention légale de l’entreprise DevApp": [],
      "Information éditeur et hébergeur :": [
        "DevApp SAS, Société à action simplifié au capital de 13 000 euros",
        "Siège social : 88, Boulevard Gallieni - 92130 Issy-les-Moulineaux, France",
        "Tél. : +33 1 37 95 42 73",
        "Directeur de la publication : Aurélien Guillemot",
        "SIRET :  87637463625934",
        "Date de création : 20 Décembre 2019 ",
      ],
      "Crédits :": [
        "Crédits photo : Maxime Dubost",
        "Ergonomie et conception graphique : Christ Ulcé",
        "Développement, intégration et hébergement : Kévin Tsi",
      ],
    };
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Mentions légales"),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 8, right: 8),
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: legalNotice.keys.toList().length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: StrongrText(
                    legalNotice.keys.toList()[index],
                    bold: true,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        for (final item
                            in legalNotice[legalNotice.keys.toList()[index]])
                          Padding(
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            child: StrongrText(
                              item,
                              textAlign: TextAlign.start,
                              maxLines: 1024,
                            ),
                          ),
                      ],
                    )),
              ],
            );
          },
        ),
      ),
    );
  }
}
