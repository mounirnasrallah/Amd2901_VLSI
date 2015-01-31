#!/usr/bin/env python

try:
  import sys
  import traceback
  import os.path
  import optparse
  import Cfg
  import Hurricane
  from   Hurricane import DbU
  from   Hurricane import UpdateSession
  from   Hurricane import Breakpoint
  import Viewer
  import CRL
  from   helpers   import ErrorMessage
  import Nimbus
  import Metis
  import Mauka
  import Katabatic
  import Kite
  import Unicorn
  import placeandroute
except ImportError, e:
  module = str(e).split()[-1]

  print '[ERROR] The <%s> python module or symbol cannot be loaded.' % module
  print '        Please check the integrity of the <coriolis> package.'
  sys.exit(1)
except Exception, e:
  print '[ERROR] A strange exception occurred while loading the basic Coriolis/Python'
  print '        modules. Something may be wrong at Python/C API level.\n'
  print '        %s' % e
  sys.exit(2)


# Will be moved away from the students eyes in the future.
def checkForUnplaceds ( cell ):
  unplaceds = []
  for instance in cell.getInstances():
      if instance.getPlacementStatus() == Hurricane.PlacementStatusUNPLACED:
          unplaceds += [ instance ]
  if unplaceds:
      message = [ 'Some instances are still unplaceds:' ]
      for instance in unplaceds:
          message += [ '<%s> of model <%s>'%(str(instance.getName())
                                            ,str(instance.getMasterCell().getName())) ]
      raise ErrorMessage( 3, message )
  return


# Will be moved away from the students eyes in the future.
def breakpoint ( editor, level, message ):
  if editor:
    editor.fit()
    editor.refresh()
    Breakpoint.stop( level, message )
  return


def ScriptMain ( cell=None ):
  editor = None
  if globals().has_key('__editor'):
      print '  o  Editor detected, running in graphic mode.'
      editor = __editor

  Cfg.Configuration.pushDefaultPriority(Cfg.Parameter.Priority.CommandLine)
  Cfg.getParamBool('misc.verboseLevel1').setBool(True)
  Cfg.getParamBool('misc.verboseLevel2').setBool(True)
  Cfg.Configuration.popDefaultPriority()

  errorCode = 0
  framework = CRL.AllianceFramework.get()

  padHeight = DbU.fromLambda(400)  # TODO
  padWidth  = DbU.fromLambda(200)  # TODO
  coreSide  = DbU.fromLambda(1500)  # TODO

  # Cell must be loaded *before* opening the UpdateSession.
  print '  o  Placing <coeur>.'
  modelCoeur = framework.getCell('coeur',CRL.Catalog.State.Logical)

  UpdateSession.open()
  try:
    modelCoeur.setAbutmentBox( Hurricane.Box( DbU.fromLambda(0)
                                            , DbU.fromLambda(0)
                                            , coreSide
                                            , coreSide
                                            ) )
   # Cannot place a rail if at least one instance is placed.
   # (to compute the orientation of the cells rows)
   #placeandroute.pyAlimVerticalRail( modelCoeur, coreSide/DbU.fromLambda(5.0*2) )

  except Exception, e:
      print e; errorCode = 1

 # For the geometrical modifications to be taken into account, we must
 # close this UpdateSession now. So the chip will see the core correctly.
  UpdateSession.close()
  if errorCode: sys.exit(errorCode)
    
  print '  o  Placing <chip>.'
  amd2901 = framework.getCell('amd2901',CRL.Catalog.State.Logical)
  if editor: editor.setCell(amd2901)

  UpdateSession.open()
  try:

    chipSide = DbU.fromLambda(3200) # TODO: Le chip est carre, avec 11 plots par face.
    abutmentBoxChip = Hurricane.Box( DbU.fromLambda(0)
                                   , DbU.fromLambda(0)
                                   , chipSide
                                   , chipSide
                                   )
    amd2901.setAbutmentBox( abutmentBoxChip )

    instanceCoeur = amd2901.getInstance( 'core' )
    instanceCoeur.setTransformation(Hurricane.Transformation( (chipSide-coreSide)/2
                                                            , (chipSide-coreSide)/2
                                                            , Hurricane.OrientationID ) )
    instanceCoeur.setPlacementStatus( Hurricane.PlacementStatusPLACED )
  
   # TODO: Placing pads

    northPads = [ 'p_a1','p_a0','p_r0','p_r3','p_vddeck0','p_vddeck1','p_b3','p_b2','p_b1','p_b0','p_q0' ] 
    southPads = [ 'p_y0','p_y1','p_y2','p_y3','p_vsseck0','p_vsseck1','p_noe','p_zero','p_f3','p_ovr','p_cout' ]
    eastPads  = [ 'p_np','p_ng','p_i2','p_i1','p_vddick0','p_vssick0','p_i0','p_i8','p_i7','p_i6','p_q3' ]
    westPads  = [ 'p_cin','p_i5','p_i4','p_i3','p_d0','p_d1','p_d2','p_d3','p_ck','p_a3','p_a2' ]
  
    for (key,listPads) in {'south':southPads, 'east':eastPads, 'north':northPads, 'west':westPads}.iteritems(): 
        print '  o  Pads on %s side:' %key
       
        x0 = 500
        y0 = 500
        for ipad in range(len(listPads)):
            pad = amd2901.getInstance( listPads[ipad] )
            print '     - Placing pad: <%s> (model:<%s>).' % (listPads[ipad],str(pad.getMasterCell().getName()))
  
            # south
            if key == 'south' :
               xpad = DbU.fromLambda(x0+200*ipad)  # TODO
               ypad = DbU.fromLambda(400)  # TODO
               pad.setTransformation( Hurricane.Transformation( xpad, ypad, Hurricane.OrientationMY) )
            
            # east
            if key == 'east' :
               xpad = DbU.fromLambda(3200-400)  # TODO
               ypad = DbU.fromLambda(y0 + 200 + 200*ipad) # TODO
               pad.setTransformation( Hurricane.Transformation( xpad, ypad, Hurricane.OrientationR3) )

            # north
            if key == 'north' :
               xpad = DbU.fromLambda(x0 + 200*ipad)  # TODO
               ypad = DbU.fromLambda(3200-400)  # TODO
               pad.setTransformation( Hurricane.Transformation( xpad, ypad, Hurricane.OrientationID) )

            # west
            if key == 'west' :
               xpad = DbU.fromLambda(400)  # TODO
               ypad = DbU.fromLambda(y0 + 200*ipad)  # TODO
               pad.setTransformation( Hurricane.Transformation( xpad, ypad, Hurricane.OrientationR1) )

            pad.setPlacementStatus( Hurricane.PlacementStatusPLACED )
  
  except ErrorMessage, e:
      print e; errorCode = e.code
  except Exception, e:
      print '\n\n', e; errorCode = 1
      traceback.print_tb(sys.exc_info()[2])

  UpdateSession.close()
  if errorCode: sys.exit(errorCode)

  breakpoint( editor, 1, 'Chip After Pad Placement' )

  try:
   # Now run the tools.
    coeur = framework.getCell('coeur',CRL.Catalog.State.Logical)
  
    mauka  = Mauka.MaukaEngine.create(coeur)
    mauka.run()
    mauka.destroy()

    breakpoint( editor, 1, 'Core After Standard Cell Placement' )
  
    placeandroute.pyAlimConnectors(coeur)
  
   # This is gross. It's the ghost of Wu Yifei and his demonic code...
   # Will not be needed in the future (dynamic detection based on the
   # transformations).
    for pad in southPads: placeandroute.pad_south += [ amd2901.getInstance(pad) ]
    for pad in northPads: placeandroute.pad_north += [ amd2901.getInstance(pad) ]
    for pad in eastPads:  placeandroute.pad_east  += [ amd2901.getInstance(pad) ]
    for pad in westPads:  placeandroute.pad_west  += [ amd2901.getInstance(pad) ]

    placeandroute.pyPowerRing( amd2901, amd2901.getInstance('core'), 3 )
    placeandroute.pyRouteCk  ( amd2901, amd2901.getNet('ckc') )
    breakpoint( editor, 1, 'Core After Clock & Power Routing' )

    kite = Kite.KiteEngine.create( amd2901 )
    kite.runGlobalRouter( Kite.BuildGlobalSolution )
    kite.loadGlobalRouting( Katabatic.LoadGrByNet, [] )
    kite.layerAssign( Katabatic.NoNetLayerAssign )
    kite.runNegociate()
    kite.finalizeLayout()
    kite.destroy()
  
   # Write back layout to disk if everything has gone fine.
    for instance in modelCoeur.getInstances():
      framework.saveCell( instance.getMasterCell(), CRL.Catalog.State.Physical )

    framework.saveCell( modelCoeur, CRL.Catalog.State.Physical )
    framework.saveCell( amd2901   , CRL.Catalog.State.Physical )

  except ErrorMessage, e:
      print e; errorCode = e.code
  except Exception, e:
      print '\n\n', e; errorCode = 1
      traceback.print_tb(sys.exc_info()[2])
  
  if editor: editor.setCell(amd2901)
      
  return 0


if __name__ == '__main__':
  ScriptMain()

  sys.exit(0)
