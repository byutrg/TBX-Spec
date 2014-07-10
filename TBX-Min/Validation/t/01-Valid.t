# Test correct TBX-Min examples against the RNG and XSD schemas
use strict;
use warnings;
use t::TestSchema;
plan tests => 2*blocks();

for my $block(blocks()){
    my $errors = rng_validate($block->input);
    is($errors, undef, 'RNG: ' . $block->name);

    $errors = xsd_validate($block->input);
    is($errors, undef, 'XSD: ' . $block->name);
}

__DATA__
=== bare bones file
--- input
<?xml version='1.0' encoding="UTF-8"?>
<TBX dialect="TBX-Min">
    <header>
        <id>TBX sample</id>
        <languages source="de" target="en"/>
    </header>
    <body>
        <termEntry id="C002">
            <langSet xml:lang="en">
                <tig>
                    <term>dog</term>
                </tig>
            </langSet>
        </termEntry>
    </body>
</TBX>

=== full header
--- input
<?xml version='1.0' encoding="UTF-8"?>
<TBX dialect="TBX-Min">
    <header>
        <id>TBX sample</id>
        <languages source="de" target="en"/>
        <description>A short sample file demonstrating TBX-Min</description>
        <dateCreated>2013-11-12T00:00:00</dateCreated>
        <creator>Klaus-Dirk Schmidt</creator>
        <directionality>bidirectional</directionality>
        <license>CC BY license can be freely copied and modified</license>
    </header>
    <body>
        <termEntry id="C002">
            <langSet xml:lang="en">
                <tig>
                    <term>dog</term>
                </tig>
            </langSet>
        </termEntry>
    </body>
</TBX>

=== different order in header
--- input
<?xml version='1.0' encoding="UTF-8"?>
<TBX dialect="TBX-Min">
    <header>
        <license>CC BY license can be freely copied and modified</license>
        <directionality>bidirectional</directionality>
        <creator>Klaus-Dirk Schmidt</creator>
        <description>A short sample file demonstrating TBX-Min</description>
        <dateCreated>2013-11-12T00:00:00</dateCreated>
        <languages source="de" target="en"/>
        <id>TBX sample</id>
    </header>
    <body>
        <termEntry id="C002">
            <langSet xml:lang="en">
                <tig>
                    <term>dog</term>
                </tig>
            </langSet>
        </termEntry>
    </body>
</TBX>

=== monodirectional
--- input
<?xml version='1.0' encoding="UTF-8"?>
<TBX dialect="TBX-Min">
    <header>
        <id>TBX sample</id>
        <languages source="de" target="en"/>
        <directionality>monodirectional</directionality>
    </header>
    <body>
        <termEntry id="C002">
            <langSet xml:lang="en">
                <tig>
                    <term>dog</term>
                </tig>
            </langSet>
        </termEntry>
    </body>
</TBX>

=== multiple entries
--- input
<?xml version='1.0' encoding="UTF-8"?>
<TBX dialect="TBX-Min">
    <header>
        <id>TBX sample</id>
        <languages source="de" target="en"/>
    </header>
    <body>
        <termEntry id="C002">
            <langSet xml:lang="en">
                <tig>
                    <term>dog</term>
                </tig>
            </langSet>
        </termEntry>
        <termEntry id="C003">
            <langSet xml:lang="en">
                <tig>
                    <term>dog</term>
                </tig>
            </langSet>
        </termEntry>
    </body>
</TBX>

=== subjectField before langSet
--- input
<?xml version='1.0' encoding="UTF-8"?>
<TBX dialect="TBX-Min">
    <header>
        <id>TBX sample</id>
        <languages source="de" target="en"/>
    </header>
    <body>
        <termEntry id="C002">
            <subjectField>whatever</subjectField>
            <langSet xml:lang="en">
                <tig>
                    <term>dog</term>
                </tig>
            </langSet>
        </termEntry>
    </body>
</TBX>

=== subjectField after langSet
--- input
<?xml version='1.0' encoding="UTF-8"?>
<TBX dialect="TBX-Min">
    <header>
        <id>TBX sample</id>
        <languages source="de" target="en"/>
    </header>
    <body>
        <termEntry id="C002">
            <langSet xml:lang="en">
                <tig>
                    <term>dog</term>
                </tig>
            </langSet>
            <subjectField>whatever</subjectField>
        </termEntry>
    </body>
</TBX>

=== multiple langSets
--- input
<?xml version='1.0' encoding="UTF-8"?>
<TBX dialect="TBX-Min">
    <header>
        <id>TBX sample</id>
        <languages source="de" target="en"/>
    </header>
    <body>
        <termEntry id="C002">
            <langSet xml:lang="en">
                <tig>
                    <term>dog</term>
                </tig>
            </langSet>
            <langSet xml:lang="de">
                <tig>
                    <term>hund</term>
                </tig>
            </langSet>
        </termEntry>
    </body>
</TBX>

=== full tig
--- input
<?xml version='1.0' encoding="UTF-8"?>
<TBX dialect="TBX-Min">
    <header>
        <id>TBX sample</id>
        <languages source="de" target="en"/>
    </header>
    <body>
        <termEntry id="C002">
            <langSet xml:lang="en">
                <tig>
                    <term>dog</term>
                    <note>cute!</note>
                    <termStatus>preferred</termStatus>
                    <customer>SAP</customer>
                    <partOfSpeech>noun</partOfSpeech>
                </tig>
            </langSet>
        </termEntry>
    </body>
</TBX>

=== different order in tig
--- input
<?xml version='1.0' encoding="UTF-8"?>
<TBX dialect="TBX-Min">
    <header>
        <id>TBX sample</id>
        <languages source="de" target="en"/>
    </header>
    <body>
        <termEntry id="C002">
            <langSet xml:lang="en">
                <tig>
                    <partOfSpeech>noun</partOfSpeech>
                    <customer>SAP</customer>
                    <note>cute!</note>
                    <termStatus>preferred</termStatus>
                    <term>dog</term>
                </tig>
            </langSet>
        </termEntry>
    </body>
</TBX>

=== partOfSpeech other values
--- input
<?xml version='1.0' encoding="UTF-8"?>
<TBX dialect="TBX-Min">
    <header>
        <id>TBX sample</id>
        <languages source="de" target="en"/>
    </header>
    <body>
        <termEntry id="C002">
            <langSet xml:lang="en">
                <tig>
                    <term>dog</term>
                    <partOfSpeech>noun</partOfSpeech>
                </tig>
                <tig>
                    <term>dog</term>
                    <partOfSpeech>verb</partOfSpeech>
                </tig>
                <tig>
                    <term>dog</term>
                    <partOfSpeech>adjective</partOfSpeech>
                </tig>
                <tig>
                    <term>dog</term>
                    <partOfSpeech>adverb</partOfSpeech>
                </tig>
                <tig>
                    <term>dog</term>
                    <partOfSpeech>properNoun</partOfSpeech>
                </tig>
                <tig>
                    <term>dog</term>
                    <partOfSpeech>other</partOfSpeech>
                </tig>
            </langSet>
        </termEntry>
    </body>
</TBX>

=== termStatus other values
--- input
<?xml version='1.0' encoding="UTF-8"?>
<TBX dialect="TBX-Min">
    <header>
        <id>TBX sample</id>
        <languages source="de" target="en"/>
    </header>
    <body>
        <termEntry id="C002">
            <langSet xml:lang="en">
                <tig>
                    <term>dog</term>
                    <termStatus>preferred</termStatus>
                </tig>
                <tig>
                    <term>dog</term>
                    <termStatus>admitted</termStatus>
                </tig>
                <tig>
                    <term>dog</term>
                    <termStatus>notRecommended</termStatus>
                </tig>
                <tig>
                    <term>dog</term>
                    <termStatus>obsolete</termStatus>
                </tig>
            </langSet>
        </termEntry>
    </body>
</TBX>
