﻿using System;
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
    public class RegionsController : ApiController
    {
        private Week16_DBChallengeEntities db = new Week16_DBChallengeEntities();

        // GET: api/Regions
        public IQueryable<Region> GetRegions()
        {
            return db.Regions;
        }

        // GET: api/Regions/5
        [ResponseType(typeof(Region))]
        public async Task<IHttpActionResult> GetRegion(string id)
        {
            Region region = await db.Regions.FindAsync(id);
            if (region == null)
            {
                return NotFound();
            }

            return Ok(region);
        }

        // PUT: api/Regions/5
        [ResponseType(typeof(void))]
        public async Task<IHttpActionResult> PutRegion(string id, Region region)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != region.RegionName)
            {
                return BadRequest();
            }

            db.Entry(region).State = EntityState.Modified;

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!RegionExists(id))
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

        // POST: api/Regions
        [ResponseType(typeof(Region))]
        public async Task<IHttpActionResult> PostRegion(Region region)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Regions.Add(region);

            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateException)
            {
                if (RegionExists(region.RegionName))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = region.RegionName }, region);
        }

        // DELETE: api/Regions/5
        [ResponseType(typeof(Region))]
        public async Task<IHttpActionResult> DeleteRegion(string id)
        {
            Region region = await db.Regions.FindAsync(id);
            if (region == null)
            {
                return NotFound();
            }

            db.Regions.Remove(region);
            await db.SaveChangesAsync();

            return Ok(region);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool RegionExists(string id)
        {
            return db.Regions.Count(e => e.RegionName == id) > 0;
        }
    }
}