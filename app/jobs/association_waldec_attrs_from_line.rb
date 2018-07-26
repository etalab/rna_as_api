# rubocop:disable Metrics/AbcSize
# rubocop:disable Metrics/MethodLength

class AssociationWaldecAttrsFromLine
  include Singleton

  def call(line)
    association_waldec_attrs = {
      is_waldec: 'true',
      id_association: line[:id],
      id_ex_association: line[:id_ex],
      siret: line[:siret],
      numero_reconnaissance_utilite_publique: line[:rup_mi],
      code_gestion: line[:gestion],
      date_creation: line[:date_creat],
      date_derniere_declaration: line[:date_decla],
      date_publication_creation: line[:date_publi],
      date_declaration_dissolution: line[:dte_disso],
      nature: line[:nature],
      groupement: line[:groupement],
      titre: line[:titre],
      titre_court: line[:titre_court],
      objet: line[:objet],
      objet_social1: line[:objet_social1],
      objet_social2: line[:objet_social2],
      adresse_siege: line[:adrs_complement],
      adresse_numero_voie: line[:adrs_numvoie],
      adresse_repetition: line[:adrs_repetition],
      adresse_type_voie: line[:adrs_typevoie],
      adresse_libelle_voie: line[:adrs_libvoie],
      adresse_distribution: line[:adrs_distrib],
      adresse_code_insee: line[:adrs_codeinsee],
      adresse_code_postal: line[:adrs_codepostal],
      adresse_libelle_commune: line[:adrs_libcommune],
      adresse_gestion_nom: line[:adrg_declarant],
      adresse_gestion_format_postal: line[:adrg_complemid],
      adresse_gestion_geo: line[:adrg_complemgeo],
      adresse_gestion_libelle_voie: line[:adrg_libvoie],
      adresse_gestion_distribution: line[:adrg_distrib],
      adresse_gestion_code_postal: line[:adrg_codepostal],
      adresse_gestion_acheminement: line[:adrg_achemine],
      adresse_gestion_pays: line[:adrg_pays],
      dirigeant_civilite: line[:dir_civilite],
      telephone: line[:telephone],
      site_web: line[:siteweb],
      email: line[:email],
      autorisation_publication_web: line[:publiweb],
      observation: line[:observation],
      position_activite: line[:position],
      derniere_maj: line[:maj_time]
    }
    association_waldec_attrs
  end
end

# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
