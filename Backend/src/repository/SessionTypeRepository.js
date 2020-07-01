import SessionType from "../models/SessionType";
import clt from "../core/config/database";

const repository = {};

repository.readSessionType = async (req) => {
  let session_type_list = [];
  let sql = `
        SELECT id_session_type, name, description
        FROM _session_type
    `;
  try {
    var result = await clt.query(sql);
    if (result.rowCount > 0) {
      result.rows.forEach((row) => {
        session_type_list.push(
          new SessionType(row.id_session_type, row.name, row.description)
        );
      });
    }
    console.log(session_type_list);
    return session_type_list;
  } catch (error) {
    console.log(error);
  }
};

export default repository;
