using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Threading.Tasks;
using System.Web.Http;
using System.Web.Http.Description;
using DBAPI.Models;

namespace DBAPI.Controllers
{
    public class SegmentsController : ApiController
    {
        private Week16_DBChallengeEntities db = new Week16_DBChallengeEntities();

        // GET: api/Segments
        public IQueryable<Segment> GetSegments()
        {
            return db.Segments;
        }

        // GET: api/Segments/5
        [ResponseType(typeof(Segment))]
        public async Task<IHttpActionResult> GetSegment(int id)
        {
            Segment segment = await db.Segments.FindAsync(id);
            if (segment == null)
            {
                return NotFound();
            }

            return Ok(segment);
        }

        // PUT: api/Segments/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutSegment(int id, Segment segment)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != segment.SegtID)
            {
                return BadRequest();
            }

            db.Entry(segment).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!SegmentExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Segments
        [ResponseType(typeof(Segment))]
        public async Task<IHttpActionResult> PostSegment(Segment segment)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Segments.Add(segment);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (SegmentExists(segment.SegtID))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = segment.SegtID }, segment);
        }

        // DELETE: api/Segments/5
        [ResponseType(typeof(Segment))]
        public async Task<IHttpActionResult> DeleteSegment(int id)
        {
            Segment segment = await db.Segments.FindAsync(id);
            if (segment == null)
            {
                return NotFound();
            }

            db.Segments.Remove(segment);
            await db.SaveChangesAsync();

            return Ok(segment);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool SegmentExists(int id)
        {
            return db.Segments.Count(e => e.SegtID == id) > 0;
        }
    }
}