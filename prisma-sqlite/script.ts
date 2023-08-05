import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient()

async function main() {
    // TODO: Create User with Posts;
    // const user = await prisma.user.create({
    //     data: {
    //         name: 'Bob',
    //         email: 'bob@prisma.io',
    //         posts: {
    //             create: {
    //                 title: 'Hello World',
    //             },
    //         },
    //     },
    // })

    // Output User with Posts;
    const usersWithPosts = await prisma.user.findMany({
        include: {
            posts: true,
        },
    })

    console.dir(usersWithPosts, { depth: null })
}

main()
    .then(async () => {
        await prisma.$disconnect()
    })
    .catch(async (e) => {
        console.error(e)
        await prisma.$disconnect()
        process.exit(1)
    })